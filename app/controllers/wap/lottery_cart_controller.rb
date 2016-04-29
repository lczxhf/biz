class Wap::LotteryCartController < Wap::ApplicationController
  layout 'wap_no_bottom'

  def index
    @title = '购物车'
    @items = LotteryCartItem.get_cart_by_user @current_user
  end


  def create
    prize_activity = PrizeActivity.find_by_id params[:prize_activity_id]
    render json:{result_code: -1} and return if prize_activity.nil?
    cart_item = LotteryCartItem.where(user: @current_user,prize_activity_id:params[:prize_activity_id]).first
    if cart_item
      cart_item.num += prize_activity.prize.sale_unit
      cart_item.save
    else
      LotteryCartItem.create num: prize_activity.prize.sale_unit, user_id: @current_user.id, prize_activity_id: params[:prize_activity_id]  
    end

    render json:{result_code: 1}
  end

  def destroy
    cart_item = LotteryCartItem.find_by_id params[:id]
    cart_item.delete

    render json:{result_code: 1}
  end

end
