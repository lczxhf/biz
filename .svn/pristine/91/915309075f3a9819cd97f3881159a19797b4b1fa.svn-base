class Admin::OrderController < Admin::ApplicationController
  before_filter :set_order, except: [:index, :new]

  def index    
    @columns = ['_id','sn', 'cash_amount', 'consignee', 'mobile', 'state', 'created_at']    
    @opts[:hide_new] = true
    do_index

  end

  def update
    # @item = Order.find(params[:id])    

    need_params = params[:order].to_hash
    # G.t need_params[:act]

    if params["act"].to_i == 1
      @item.express_sn = need_params["express_sn"]
      @item.express_id = need_params["express"]
      @item.save!

      @item.action_send_goods
    elsif params["act"].to_i == 2
      @item.update_attributes(need_params)

      @item.create_record! "修改订单总价为: #{need_params['cash_amount']}"
    end

    redirect_to ace_path @item
  end

  def show
    
  end

  def edit
    render 'show'
  end


  def action

    if params[:act] == "action_sign_goods"
      @item.action_sign_goods
    end

    if params[:act] == "action_done"
      @item.action_done
    end

    if params[:act] == "action_cancel"

      @item.action_cancel
    end

    render json:{result_code: 1}
  end

  def query_shippment
    if @item.express
      response = RestClient.get "http://m.kuaidi100.com/query?type=#{@item.express.code}&postid=#{@item.express_sn}"     
        if response.code != 200
          logger.info response
          return render json:{result_code: 0}
        end
      res = JSON.parse response
      render json:res["data"] and return
    else
      render json: []
    end
  end

  private

  def set_order
    @item = Order.find(params[:id])   if params[:id]
    @item.current_admin = @admin_user if @item
  end
end
