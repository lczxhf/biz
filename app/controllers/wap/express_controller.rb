class Wap::ExpressController < Wap::ForceLoginController
  layout 'wap_no_bottom'

  def show
    @title = '订单跟踪'
    @order = Order.find params[:order]

    url = "http://m.kuaidi100.com/query?type=#{@order.express.code}&postid=#{@order.express_sn}"     
    # G.t url

    response = RestClient.get url
    @tracks = JSON.parse response    
    G.t @tracks

  end
end
