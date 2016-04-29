class Wap::UserAddressController < Wap::ForceLoginController
  layout 'wap_no_bottom'

  def new
    @title = "添加收货地址"

    flash.now[:referer] = '/wap/user_address'
  end

  def index
    @items = @current_user.user_addresses
    flash.now[:referer] = '/wap/user_profile'

    @title = '我的收货地址'
  end

  def select
    # layout 'wap_no_bottom'
    flash.now[:referer] = '/wap/order/new'

    @items = @current_user.user_addresses
    @title = '选择收货地址'

    render 'select', layout: 'wap_no_bottom'
  end

  def edit
    flash.now[:referer] = '/wap/user_address'
    @title = '编辑收货地址'
  end

end
