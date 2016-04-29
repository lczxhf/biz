class Admin::PayConfigController < Admin::ApplicationController

  def index
    @wxpay = WxpayConfig.find_or_create_by name:"微信支付"
    @alipay = AlipayConfig.find_or_create_by name:"支付宝支付"
  end

end
