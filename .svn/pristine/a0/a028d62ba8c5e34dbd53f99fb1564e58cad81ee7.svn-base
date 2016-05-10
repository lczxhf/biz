class LotteryOrderItem
  include  BaseModel
  include Mongoid::Search    

  has_many :lotteries

  field :num, type: Integer   # 元
  field :part, type: Integer,default: 0
  belongs_to :prize_activity  
  belongs_to :lottery_order
  belongs_to :prize

  before_create :set_part

  field :pay_state, type:Integer, default:0 
  field_display :pay_state, {0=>"待付款", 1=>"已支付", 2 => "已退款" }  

  search_in :prize_activity => :name, :lotteries => :seq, :lottery_order => :user

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
        return false if prize_activity.lotteries.where(used:0).count <= 0
        if prize_activity.lotteries.where(:random.gt => rand, used:0).update(used:2, lottery_order_item:self.id).first['n'] == 1 #update first match 
          lottery_count += 1
        end       

      end
    if Lottery.where(lottery_order_item:self).empty?
      return false
    end

    prize_activity.trigger_update
    true
  end

  # 3 分钟 无支付 
  def unlock_lottery
      self.lotteries.update_all(used:0,lottery_order_item_id:nil)
      prize_activity.trigger_update
  end

  def self.rollback_lottery(item_arr)
      Lottery.in(lottery_order_item_id:item_arr).update_all(lottery_order_item_id:nil,used:0)
  end

  # 支付前, 检查一下剩余 lottery数目是否够
  def can_pay?
    self.prize_activity.remain_share >= self.part
  end

  def on_pay_done
      self.lotteries.update_all(used:1, user_id:self.lottery_order.user_id)
      self.update_attribute :pay_state, 1
      self.prize_activity.check_if_done
  end

end
