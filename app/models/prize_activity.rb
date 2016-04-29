class PrizeActivity
  include  BaseModel

  
  field :name, type: String
  field :begin_time, type:Time
  field :lucky_no, type:Integer
  field :end_time, type: Time

  scope :ongoing, ->{ where(:begin_time.lt =>  Time.now)}  
  
  has_many :lotteries
  has_many :lottery_cart_items, autosave: true
  has_many :lottery_order_items
  belongs_to :prize

  after_create :init_lotteries

  def init_lotteries
    (0...self.prize.total_share).each do  |i|
      lottery = Lottery.create prize_activity:self, seq:(i + 10000001)
    end
  end

  def update_by_lottery
    logger.info  "update_by_lottery"
    return if self.lotteries.where(used:0).first
    self.lucky_no = calc_lucky_no
    self.end_time = Time.now
    if self.save
      self.lotteries.where(seq:lucky_no).first.update_attribute(:is_winner,true)
    end
  end

  def calc_lucky_no
    last_fifty_lotteries.map(&:u_at).map(&:to_digital).inject(&:+) % prize.total_share + 10000001    
  end

  def is_done?
    !lucky_no.nil?
  end

  def get_A_number
      last_fifty_lotteries.map(&:u_at).map(&:to_digital).inject(&:+)  
  end
  def last_fifty_lotteries
      lotteries.desc(:u_at).limit(50)
  end
  def total_share
    prize.total_share
  end

  def get_lucky_user
      return '无' unless is_done?
      self.lotteries.where(seq:lucky_no).first.user
  end

  def get_all_order(num=true)
      items_ids = self.lotteries.where(used:1).distinct(:lottery_order_item_id)
      if num == true
        LotteryOrderItem.includes(lottery_order: :user).in(id:items_ids).order(c_at: :desc)
      else
        LotteryOrderItem.includes(lottery_order: :user).in(id:items_ids).order(c_at: :desc).page(1).per(num)
      end
  end
  def get_lucky_order
      self.lotteries.where(seq:lucky_no).first.lottery_order_item.lottery_order
  end
  def time_of_user_buy(user=nil)
      user ||= get_lucky_user
      user.lotteries.where(prize_activity:self).count
  end

  def check_if_done
      logger.info  "check_if_done"
      if remain_share <= 0 
          update_by_lottery
      end
  end

  def saled_share
    total_share - remain_share
  end

  def remain_share
    self.lotteries.where(:used => 0).count
  end

  def prev_activity
    PrizeActivity.where(prize: prize, :begin_time.lt => self.begin_time).asc(:begin_time).last
  end

  def trigger_update
    Delayed::Job.enqueue BroadcastJob.new( chanel:'prize_channel', message: {progress: (remain_share.to_f / total_share) * 100, remain: remain_share, id: self.id, state: 'in progress'})
  end

end
