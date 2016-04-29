class Coupon
  include  BaseModel

  field :name
  field :value, type:Integer

  field :expire_date, type:Date, :default => 7.days.from_now

  field :is_used, default:false

  belongs_to :user
  belongs_to :order

  #判断卡券是否过期
  #返回 过期：true   未过期： false
  def expired?
    Time.now > expire_date
  end

  #使用卡券
  def use!
    write_attribute :is_used, true
  end

end
