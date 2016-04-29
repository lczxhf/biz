class FavoriteProduct
  include  BaseModel

  belongs_to :user
  belongs_to :product


  class << self
    #返回用户的收藏列表
    #参数 用户 第几页
    #返回 Array[favorite_product]
    def get_favorites (user, page)      

      favorites = FavoriteProduct.where(user:user).page(page)
      favorites.map { |c| {
          favorite_id: c.id,
          product:{product_id: c.product.id,
          name: c.product.name,          
          price: c.product.price,
          rating: c.product.rating,
          photo: c.product.get_photos.first.url_for(:thumb)}
      } }

    end

  end

end
