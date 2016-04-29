class Photo

  include Mongoid::Document
  include Mongoid::Timestamps::Short      
  include BizModule

  field :name
  field :url

  belongs_to :product
  belongs_to :shop
  belongs_to :variant
  # belongs_to :category
  # belongs_to :index_banner
  # belongs_to :order_product_comment

  def url_for(para = :app)
    url.gsub(".png", "_#{para}.png")
  end

end
