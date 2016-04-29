class Admin::WxpayConfigController < Admin::ApplicationController
  def edit
    @item = WxpayConfig.first
  end

  def update
      item = WxpayConfig.find(params[:id])
    # item.update
    item.update_attributes(params[:wxpay_config].to_hash)

    redirect_to '/admin/pay_config'

  end

end
