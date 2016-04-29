class Api::OrderController < Api::CheckLoginController
  def index

    @items = Order.all.desc(:sn).page(@page) if params[:t] == 'all'
    @items = Order.wait_pay.desc(:sn).page(@page) if params[:t] == 'pay'
    @items = Order.wait_send.desc(:sn).page(@page) if params[:t] == 'express'
    @items = Order.wait_receive.desc(:sn).page(@page) if params[:t] == 'confirm'
    @items = Order.wait_comment.desc(:sn).page(@page) if params[:t] == 'comment'
    @items ||= []
    
    render 'index.json'
  end

  def show
    @order = Order.find params[:id]
  end

  def create
    temp_order = @current_user.temp_order

    _param = params[:order]

    user_address = temp_order.user_address
    if params[:address_id]
      user_address = UserAddress.find params[:address_id]
    end

    order = Order.new user:@current_user, remark: _param[:remark], shipping_type: _param[:shipping_type]
    order.fill_address user_address

    temp_order.order_products.update_all temp_order_id: nil, order_id:order.id
    order.reload
    order.cash_discount = temp_order.cash_discount
    order.reward_score = temp_order.reward_score
    order.ori_amount = temp_order.total
    
    order.calc_shipping_fee

    G.t "order shipping_fee #{order.shipping_fee}"
    
    order.cash_amount = order.ori_amount + order.shipping_fee - order.cash_discount

    now = Time.now
    order.sn = "#{now.year%100}#{now.month}#{now.day}#{Time.now.to_i % 100000}"
    order.save

    remove_cart order.order_products.map(&:variant).map(&:id)

    render json:{result_code: 1, order: order}
  end

  def cancel
    @order = Order.find params[:id]

    if @order.can_cancel? and @order.user == @current_user

      @order.cancel!
      if @order.can_do_refund?

        batch_no = Alipay::Utils.generate_batch_no 

        url = Alipay::Service.refund_fastpay_by_platform_pwd_url(
          batch_no: batch_no,
          data: [{
            trade_no: @order.trade_no,
            amount: @order.real_amount,
            reason: 'user refund'
          }],

          notify_url: "#{Settings.site_url}/wap/order/#{@order.id}/on_refund"
        )

      end

      G.t url      
      render json:{result_code: 1} and return
    end

    render json:{result_code: 0, error_message:"不能取消订单"}
  end

  def on_refund
    G.t params
    @order = Order.find params[:id]
    render text: 'success' and return
  end

  def confirm
    @order = Order.find params[:id]
    @order.action_done
    
    render json:{result_code: 1}
  end

  def webpay
    @order = Order.find params[:id]

    url = Alipay::Service.create_direct_pay_by_user_wap_url({
      out_trade_no: @order.id.to_s,
      _input_charset: 'utf-8',
      subject: "#{@order.product_names}",
      total_fee: '0.01',
      return_url: "#{Settings.site_url}/wap/order/#{@order.id}",
      notify_url: "#{Settings.site_url}/api/notify_url"
      },
      
      {
       pid: AlipayConfig.first.parter_id,
       key: AlipayConfig.first.sec_key
      }
    )

    # G.t url
    redirect_to url

  end

  private
  #删除用户购物车 并且将temp_order删除！
  def remove_cart variant_ids
    @current_user.cart_line_items.where(:variant_id.in =>  variant_ids).delete_all

    @current_user.temp_order.delete
  end

end
