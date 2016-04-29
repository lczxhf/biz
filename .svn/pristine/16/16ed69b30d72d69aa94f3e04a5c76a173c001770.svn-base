class Admin::AdminUserController < Admin::ApplicationController

  def index    
    @columns = ['_id','username', 'name', 'role', 'sign_in_count' ]
    @opts[:hide_batch_action] = true
    do_index
  end

  def edit
    @item = AdminUser.find params[:id]
  end

  def new
    @item = AdminUser.new
  end

  def create
    need_params = params[:admin_user].to_hash
    if need_params[:password] != need_params[:password_confirmation]
      return
    end

    if check_uniq need_params[:username] == false
      render '422.html' and return
    end

    need_params[:email] =  "#{need_params[:username]}@lmsj.com"

    @item = AdminUser.new need_params

    if AdminUser.where(username: need_params[:username]).first
      return redirect_to ace_path_index @item  
    end
    
    if @item.save!
      redirect_to ace_path @item
    else
      return redirect_to ace_path_index @item  
    end

  end

  def update
    @item = AdminUser.find params[:id]
    need_params = params[:admin_user].to_hash
    if need_params[:password] != need_params[:password_confirmation]
      return
    end
    
    @item.update_attributes need_params
    return redirect_to ace_path_index @item    
  end

  private 
  def check_uniq (mob)
    AdminUser.where(username:mob).empty?
  end
end
