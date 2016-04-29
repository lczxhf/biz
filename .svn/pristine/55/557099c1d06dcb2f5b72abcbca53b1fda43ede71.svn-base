class Api::CartController < Api::CheckLoginController
  skip_before_filter :set_item

  def create
    if params[:product_id].present?
      product =  Product.find params[:product_id]
      variant = product.variants.first 
    end

    variant = Variant.find(params[:variant_id]) if params[:variant_id].present?

    render json: { result_code: Settings.product_is_null } and return if variant.nil?

    num = params[:num].to_i
    record = CartLineItem.where(user:@current_user, variant: variant).first

    if record.present?
      record.update_attributes!(num: num) if num != 0
      record.delete if num == 0
    else
      CartLineItem.create!(num: num, user: @current_user, variant: variant)
    end

    show_cart
  end

  def index
   show_cart
  end


  def destroy
    variant = Variant.find params[:variant_id] if  params[:variant_id]
    record = CartLineItem.where(user:@current_user, variant: variant).first
    record.destroy if record
    
    render json:{result_code: 1}
  end


  private
  def show_cart
   lines = CartLineItem.get_cart @current_user

    total_price = 0.0    

    if lines
      lines.each do |t|
        total_price += t[:price] * t[:num]
      end
    end

    render json: { result_code: Settings.success, cart: {total_fee: total_price, list: lines } }
  end

  def clear        
    if params[:ids]
      variant_ids = params[:ids].to_a
      @current_user.cart_items.where(:variant_id.in => variant_ids).delete_all
    else
      @current_user.cart_items.delete_all  
    end

    show_cart
  end


end
