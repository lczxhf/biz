class Wap::ApplicationController < ApplicationController
  before_action :set_title 
  before_action :invoke_wx_auth 
  before_action :set_page,  :only => [:edit, :show]

  before_action :get_wechat_sns, if: :is_wechat_brower?

  layout 'wap'

  def set_title
    @title = controller_name
  end

  def set_page
    @item = controller_name.classify.constantize.where(:id => params[:id]).first
  end

  private
   # 调用微信授权获取openid
  def invoke_wx_auth

    user = User.find_by_id session[:user_id]

    #是微信浏览器, 没有用户登录
    if is_wechat_brower? and user.nil?

      #
      if params[:state].present?
        return
      end
      # 生成授权url，再进行跳转
      sns_url =  $wechat_client.authorize_url(request.url)
      redirect_to sns_url and return
    end

    init_user
  end

  def init_user
    @current_user = User.find_by_id session[:user_id] if session[:user_id]
    @current_user ||= create_tmp_user

    save_current_user_ip
  end  

  # 在invoke_wx_auth中做了跳转之后，此方法截取
  def get_wechat_sns
    # params[:state] 这个参数是微信特定参数，所以可以以此来判断授权成功后微信回调。
    if session[:openid].blank? && params[:state].present?
      sns_info = $wechat_client.get_oauth_access_token(params[:code])
      G.t ("Weixin oauth2 response: #{sns_info.result}")

      # 重复使用相同一个code调用时：
      if sns_info.result["errcode"] != "40029"
        session[:openid] = sns_info.result["openid"]

        @current_user = create_wx_user session[:openid]
        save_current_user_ip

        G.t $wx_client.user session[:openid]
      end
    end
  end  

  def is_wechat_brower?
    request.env['HTTP_USER_AGENT'].include? 'MicroMessenger'
  end

  def create_tmp_user

    user = User.create(type:0)
    session[:user_id] = user.id
    G.t "create_tmp_user #{user.as_json}"
    user
  end

  def create_wx_user openid

    user = User.create(type:2, wx_openid: openid)
    session[:user_id] = user.id
    session[:openid] = openid
    user
  end

  def save_current_user_ip 
    G.t "ip: #{request.real_ip}"
    @current_user.client_ip = request.real_ip
    @current_user.save
  end
  
end
