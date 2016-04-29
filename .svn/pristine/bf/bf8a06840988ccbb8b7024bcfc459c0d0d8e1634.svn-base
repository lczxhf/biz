class ShippingRule
  include  BaseModel

  field :name, type:String, default:'区域费用'
  
  field :post_first_fee, type:Float # 首件费用
  field :post_first_unit, type:Integer, default: 1 #续件计费个数

  field :post_append_fee, type:Float # 续建费用
  field :post_append_unit, type:Integer, default: 1 #续件计费个数


  field :express_first_fee, type:Float # 首件费用
  field :express_first_unit, type:Integer, default: 1 #续件计费个数

  field :express_append_fee, type:Float # 续建费用
  field :express_append_unit, type:Integer, default: 1 #续件计费个数

  has_and_belongs_to_many :china_cities, class_name:"ChinaCity"  #目的地, 按目的地计价

  has_and_belongs_to_many :product

  field :shipping_type  , type:Integer, default:0  #'post', 'express'
  field_display :shipping_type, {0=>"平邮", 1=>"快递", 2 => 'EMS'}  
end
