class TempOrder
  include  BaseModel

  field :num, default:1
  field :total

  field :cash_discount,  type:Integer,default:0
  field :reward_score, type:Integer,default:0

  has_many :order_products
  belongs_to :user

  belongs_to :user_address

  field :shipping_fee, type:Integer, default: 0

  field :shipping_type, default: 0   
  field_display :shipping_type, { 0 => '平邮', 1 => '快递'}

  before_save :calc_shipping_fee

  def calc_shipping_fee
    self.shipping_fee = 0

    order_products.each do |op|
      rule = op.variant.product.shipping_rules.first  # 计算区域

      if rule
        self.shipping_fee += (rule.post_first_fee + rule.post_append_fee * (op.num - 1)) if shipping_type == 0
        self.shipping_fee += (rule.express_first_fee + rule.express_append_fee * (op.num - 1)) if shipping_type == 1
      end
    end
    
  end

end
