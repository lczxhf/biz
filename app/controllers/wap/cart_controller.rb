class Wap::CartController < Wap::ApplicationController
  layout 'wap_no_bottom'

  def index
    @title= '购物车'

    flash.now[:referer] = '/wap/home'
    gon.carts = CartLineItem.get_cart(@current_user)
  end

end
