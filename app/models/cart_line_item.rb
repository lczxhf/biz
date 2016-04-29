class CartLineItem 
  include  BaseModel
  
  field :num, type: Integer
   
  belongs_to :user
  belongs_to :variant

  class << self
    #返回某个user的购物车Array
    #参数 user
    #返回 [{},...]
    def get_cart user
      items = CartLineItem.where(user:user)
      items.map{ |c| {

        variant_id: c.variant.id,
        product_id: c.variant.product.id,
        name: c.variant.product.name,
        price: c.variant.price,
        num: c.num,
        photo: c.variant.product.get_photos[0].url,
        option_types: c.variant.option_values.map(&:option_type).map(&:name),
        option_values: c.variant.option_values.map(&:name)
        }
      }

    end
  end
end
