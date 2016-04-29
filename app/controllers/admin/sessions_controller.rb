class Admin::SessionsController <  Devise::SessionsController  

  def create
    resource = warden.authenticate!(scope: resource_name, recall: "#{controller_path}#new")
    set_flash_message(:notice, :signed_in) if is_navigational_format?   

    sign_in(resource_name, resource)    
    
    user = AdminUser.where(username:params[:admin_user][:username]).first
    # G.t "usser: #{user.as_json}"
    session[:admin] = user.id.to_s if user

    respond_to  do |format|

      format.html {redirect_to '/admin/dash_board'}
      format.json do 
          if user 
            render json:{result:1, shop: user.manager.shop}  and return
          else 
            render json:{result: -1} and return
          end
      end
    end
    
  end

  def valify_captcha!
    if !verify_rucaptcha?
      redirect_to '/', alert: ('rucaptcha.invalid') and return
    end
    true
  end

end
