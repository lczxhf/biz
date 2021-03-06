class Wap::UserController < Wap::ApplicationController

  def index
    redirect_to  new_wap_session_path  and return if @current_user.is_tmp?
    redirect_to wap_user_path @current_user
  end

  def show
    @title = '个人中心'
    @user_info = {:wait_pay => Order.wait_pay.where(user:@current_user).count, 
      :wait_send => Order.wait_send.where(user:@current_user).count,
      :wait_receive =>  Order.wait_receive.where(user:@current_user).count,
      :wait_comment =>  Order.wait_comment.where(user:@current_user).count}
  end


  def new
    @title = '注册'
  end

end
