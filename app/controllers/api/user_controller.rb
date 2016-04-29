class Api::UserController <  Api::CheckLoginController

  def upload_avatar
    if params[:avatar].nil?
      render json: { result_code: Settings.avatar_is_null }
      return
    end

    @current_user.avatar = params[:avatar]
    @current_user.save
    render json: {
      result_code: Settings.success,
      avatar: @current_user.avatar.app.url
    }
  end

  def update
    @current_user.update_attributes params[:user].to_hash
    render json:{result_code:1}
  end
  
end
