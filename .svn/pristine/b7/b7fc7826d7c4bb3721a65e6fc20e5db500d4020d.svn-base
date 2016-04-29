class LotteryOrderItem
  include  BaseModel

  has_many :lotteries

  field :num, type: Integer   # 元
  field :part, type: Integer,default: 0
  belongs_to :prize_activity  
  belongs_to :lottery_order
  belongs_to :prize

  before_create :set_part

  def update_prize
    lotteries.each{|i| i.touch}
    prize_activity.update_by_lottery
  end

  def is_winner?
    return false if prize_activity.lucky_no.nil?
    
    self.lotteries.map(&:seq).include? prize_activity.lucky_no
  end

  def set_part
      self.part = self.num / self.prize_activity.prize.sale_unit
  end
  #before pay
  def lock_lottery
    lottery_count = 0 
      while lottery_count < part
        return if prize_activity.lotteries.where(used:0).count <= 0
        lottery = prize_activity.lotteries.where(:random.gt => rand, used:0).first
        if lottery
          lottery_count += 1
          lottery.used = 2
          lottery.lottery_order_item = self
          lottery.save
        end       
      end
    if Lottery.where(lottery_order_item:self).empty?
      return false
    end
    true
  end

  # 3 分钟 无支付 
  def unlock_lottery
      self.lotteries.update_all(used:0,lottery_order_item_id:nil)
  end

  def self.rollback_lottery(item_arr)
      Lottery.in(lottery_order_item_id:item_arr).update_all(lottery_order_item_id:nil,used:0)
  end

  # 支付前, 检查一下剩余 lottery数目是否够
  def can_pay?
    self.prize_activity.remain_share >= self.part
  end

  def on_pay_done
      self.lotteries.update_all(used:1,user_id:self.lottery_order.user_id)
      self.prize_activity.check_if_done
  end

end
