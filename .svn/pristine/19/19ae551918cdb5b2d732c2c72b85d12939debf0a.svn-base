class Api::FavoriteProductController < Api::CheckLoginController

  def index
    list = FavoriteProduct.get_favorites @current_user, @page    
    render json: {result_code: Settings.success, list:list}
  end

  def create
    ids = params[:ids]
    ids ||= [params[:product_id]]
    
    ids.each do |product_id|
      product = Product.find_by_id(product_id)
      next unless product
      favorite = FavoriteProduct.create!(user: @current_user, product: product) unless FavoriteProduct.where(user: @current_user, product: product).present?
    end

    render json: { result_code: Settings.success, list: FavoriteProduct.get_favorites(@current_user, 0) }
  end

  def destroy

    FavoriteProduct.where(user: @current_user, id: params[:id]).delete_all
    
    render json: { result_code: Settings.success, list: FavoriteProduct.get_favorites(@current_user, 0) }
  end
  
end
