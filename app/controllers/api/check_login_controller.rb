class Api::CheckLoginController <  Api::ApplicationController
  before_filter :check_session

  def check_session
    if @current_user == nil
      render json: { result_code: -1, error_message:'请先登录' } and return
    end
  end
end
