class Wap::LotteryOrderController < Wap::ForceLoginController
  skip_before_action :verify_authenticity_token,  :only => [:notify]
  skip_before_action :force_login, :only => [:notify]

  layout 'wap_no_bottom'

  def index
    flash.now[:referer] = '/wap/user'
    @title = "夺宝记录"
    @items = LotteryOrder.pay_record.where(user:@current_user).map {|a| a.lottery_order_items}.flatten
    @activities = @items.map{|a| a.prize_activity }.uniq
    flash.now[:t] = params[:t]
  end

  def show
    @order = LotteryOrder.find_by_id params[:id]
    @title = '支付结果'
  end

  def new
    @title = "确认订单"
    flash.now[:referer] = '/wap/cart'

    @temp_order = @current_user.temp_order
    @default_address = @temp_order.user_address

    @default_address ||= @current_user.user_addresses.where(is_default:true).first
    @default_address ||= @current_user.user_addresses.first
  end

  def create
    items =  JSON.parse params[:lottery_order]
    if items.present?
      lottery_order = @current_user.lottery_orders.new
      lottery_order.set_user_ip(@current_user.client_ip)
      lottery_order.save
    end
    items.each do |item|
        cart = LotteryCartItem.find(item["cart_id"])
        lottery_order.lottery_order_items.create(num:item["num"],prize_activity:cart.prize_activity)
    end
    @current_user.lottery_cart_items.delete_all
    render json:{result_code:1,result_msg:lottery_order.id}
  end

  def pay
    @title = "支付订单"
    @order = LotteryOrder.includes(:lottery_order_items).find_by_id params[:id]
    if !@order.before_pay
        flash[:pay_state] = "支付失败"
        redirect_to :back
    end
  end

  def web_pay
      order = LotteryOrder.find(params[:id])
      if order.can_pay?
        #lock lottery
        url = Alipay::Service.create_direct_pay_by_user_wap_url({
          out_trade_no: order.id.to_s,
          _input_charset: 'utf-8',
          subject: "一元购",
          total_fee: '0.01',
          return_url: "#{Settings.site_url}/wap/lottery_order/#{order.id}",
          notify_url: "#{Settings.site_url}/wap/lottery_order/notify"
          },
          {
           pid: AlipayConfig.first.parter_id,
           key: AlipayConfig.first.sec_key
          }
        )
        redirect_to url
      else
        flash[:pay_state] = "很抱歉！无法支付"
        redirect_to :back
      end
      
  end

  def notify
    params.delete('controller')
    params.delete('action')
    params.delete('sign_type')
    params.delete('lottery_order')

    sign = params.delete('sign')
    string = params.sort.map { |k, v| "#{k}=#{v}" }.join('&')
    string += AlipayConfig.first.sec_key
    @order = LotteryOrder.find(params[:out_trade_no])
    Rails.logger.info("string =>#{string}")
    Rails.logger.info("sign =>#{sign}")
    Rails.logger.info("MD5 =>#{Digest::MD5.hexdigest(string)}")

    if sign == Digest::MD5.hexdigest(string)

      if params[:trade_status] == 'TRADE_FINISHED'
        # @order.update_attributes!(order_status: 100)
        G.t 'TRADE_FINISHED'
        
        render text: 'success' and return
      end

      if params[:trade_status] == 'TRADE_SUCCESS' # 交易成功
        # @order.update_attributes!(order_status: 1, pay_time: Time.now,pay_status:1)
        # change_user_coupon # 改变代金券的使用状态
        # change_user_score if @order.score_amount.present? # 改变用户积分
        G.t 'TRADE_SUCCESS'

        @order.on_pay_done params["total_fee"].to_f, params["trade_no"]
        render text: 'success' and return
      end

    end
    render text: 'faild'
  end
end
