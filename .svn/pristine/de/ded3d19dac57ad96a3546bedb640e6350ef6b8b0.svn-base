class Wap::UserProfileController < Wap::ForceLoginController
  layout 'wap_no_bottom'

  def show
  end

  def index
    @title = '个人资料'
    flash.now[:referer] = '/wap/user'
  end
  
  def edit_phone    
    flash.now[:referer] = '/wap/user_profile'
    @title = '修改电话'
  end

end
