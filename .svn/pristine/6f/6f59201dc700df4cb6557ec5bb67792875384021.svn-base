class OrderProduct
  include  BaseModel

  field :num, type:Integer, default:1
  
  field :name
  field :price, type:Float
  field :score  
  field :client_ip
  
  field :shipping_status, default:0  

  field :comment_status, type:Integer, default:1 # 评论状态
  field_display :comment_status, {1=>"待评价", 2=>"部分评价", 3=>"已评价"}
  
  belongs_to :order
  belongs_to :temp_order
  belongs_to :variant

  has_one :order_product_comment

  before_save :init_value

  def api_json
    {name: name, num: num, comment_status: comment_status, price: price, score: score, product_id: variant.product.id,order_product_id: id, photo: variant.product.get_photos.first.url, variant:variant }.as_json
  end

  #回调 设置价格和名称
  def init_value
    self.price = variant.price
    self.name = variant.product.name
  end

  def photo
    variant.product.get_photos.first
  end

end
