class Api::PayController < ApplicationController
  # before_filter :check_alipay_sign, only: [:get_alipay_notify, :get_alipay_callback]
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  def notify
  end


  def web_pay_notify # web支付回调
    # G.t params
    params.delete('controller')
    params.delete('action')
    params.delete('sign_type')
    params.delete('pay')

    sign = params.delete('sign')
    string = params.sort.map { |k, v| "#{k}=#{v}" }.join('&')
    string += AlipayConfig.first.sec_key
    @order = Order.find(params[:out_trade_no])
    Rails.logger.info("string =>#{string}")
    Rails.logger.info("sign =>#{sign}")
    Rails.logger.info("MD5 =>#{Digest::MD5.hexdigest(string)}")

    if sign == Digest::MD5.hexdigest(string)

      if params[:trade_status] == 'TRADE_FINISHED'
        # @order.update_attributes!(order_status: 100)
        G.t 'TRADE_FINISHED'
        
        render plain: 'success' and return
      end

      if params[:trade_status] == 'TRADE_SUCCESS' # 交易成功
        # @order.update_attributes!(order_status: 1, pay_time: Time.now,pay_status:1)
        # change_user_coupon # 改变代金券的使用状态
        # change_user_score if @order.score_amount.present? # 改变用户积分
        G.t 'TRADE_SUCCESS'

        @order.on_pay_done params["total_fee"].to_f, params["trade_no"]
        render plain: 'success' and return
      end

    end
    render plain: 'faild'
  end

  def alipay_callback
    render plain: 'trade success'
  end

  protected

  def json_request?
    request.format.json?
  end

end
