class Lottery
  include  BaseModel

  belongs_to :lottery_order_item
  belongs_to :prize_activity
  belongs_to :user

  field :is_winner, default:false

  field :used, type:Integer, default:0
  field_display :used, { 0 => '未使用', 1 => '已使用', 2 => "锁定"}
  field :seq, type:Integer
    
  field :random, type:Float, default: proc {rand}
  
  def value
    self.prize_activity.prize.sale_unit
  end


end
