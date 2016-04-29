class Prize
  include  BaseModel

  field :name, type: String
  field :brief, type: String    #文字说明  

  field :content #html string

  field :price, type: Integer, default:1000  # 总价, ￥元
  field :sale_unit, type: Integer, default:1  # 销售单位 , 1元起, 10元起

  field :is_o2o, type:Boolean, default:true #是否是O2O业务, 中奖用户是上门获取还是快递

  has_many :pictures
  has_many :lottery_order_items
  has_one :prize_activity

  def total_share
    price / sale_unit
  end

  
end
