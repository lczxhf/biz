class Variant
  include  BaseModel
  
  field :price, type:Float
  field :sku, type:String

  field :show, type:Boolean, default:true

  field :stock, type:Integer, default:10
  has_many :stock_records

  belongs_to :product

  has_many :photos, dependent: :destroy
  
  has_and_belongs_to_many :option_values  #[M, red]

  field :state, type: Integer, default: 0
  field_display :state, {0 => '上线', 1 => '下架',100 => '删除'}

  default_scope -> { where(state:0)}

  has_many :cart_line_items
  has_many :order_products

  def as_json(options={})
    super(:except => [:product_id, :show]).merge({
      option_types: option_values.map(&:option_type).map(&:name),
      option_values: option_values.map(&:name)
      })
  end

  def readable_specs
    option_values.map(&:name).join ','
  end

  def stock_action (num, info = 'buy')

    self.stock += num
    if self.save!
      StockRecord.create action:num, info:info
    end

  end

end
