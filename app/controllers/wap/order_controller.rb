class Wap::OrderController < Wap::ForceLoginController
  layout 'wap_no_bottom'

  def index
    flash.now[:referer] = '/wap/user'
    @title = "我的订单"
    flash.now[:t] = params[:t]
  end

  def show
    @title = "订单详情"
    @order = Order.find params[:id]
  end


  def set_title
    @title = 'order'
  end

  def new
    @title = "确认订单"
    flash.now[:referer] = '/wap/cart'

    @temp_order = @current_user.temp_order
    @default_address = @temp_order.user_address

    @default_address ||= @current_user.user_addresses.where(is_default:true).first
    @default_address ||= @current_user.user_addresses.first

  end

  def pay
    @title = "收银台"
    @order = Order.find params[:id]
  end

end
