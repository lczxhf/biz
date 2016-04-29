class Api::TempOrderController < Api::CheckLoginController

  def create

    temp_order = TempOrder.find_or_create_by :user => @current_user

    if params[:type] == 'put' and params[:address_id]
      temp_order.user_address_id = params[:address_id]
      
      temp_order.save
      render json:{result_code:1} and return
    end

    if params[:shipping_type].present? and params[:type] == 'put'
      temp_order.shipping_type = params[:shipping_type]
      temp_order.save
      render json:{result_code:1} and return
    end

    temp_order.order_products.delete_all if temp_order.order_products

    num = 0
    total = 0

    order_products = []
    params[:temp_order].each do |k, v|
      op = OrderProduct.new v.to_hash

      num += op.num.to_i
      total += op.num.to_i * op.variant.price.to_f

      op.temp_order_id = temp_order.id
      op.save

      order_products << op
    end

    temp_order.num = num
    temp_order.total = total

    discount_score = PromotionRule.get_discount_by order_products
    temp_order.cash_discount = discount_score[:cash_discount]
    temp_order.reward_score = discount_score[:reward_score]
    temp_order.save

    render json:{result_code:1}
  end


  def update

  end

end
