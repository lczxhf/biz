class Admin::AlipayConfigController < Admin::ApplicationController

  def edit
    @item = AlipayConfig.first
  end

  def update
    item = AlipayConfig.find(params[:id])
    # item.update
    item.update_attributes(params[:alipay_config].to_hash)

    redirect_to '/admin/pay_config'
  end

end
