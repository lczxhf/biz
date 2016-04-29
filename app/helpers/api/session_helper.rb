module Api::SessionHelper
  
  def send_sms(mobile, model_type)    
    sms_params = (1..4).map{|i|rand(10)}.join('')

    model_type = Settings.model_type["#{model_type}"]    
    
    ValidateCode.create ({"dest" => mobile, "template" => model_type, "code" => sms_params})

    # Sms.delay.send_sms(mobile, model_type, sms_params, Settings.sms_expire_time)
  end

  def create_new_user(params)
    @user = User.new
    @user.name = UserId.generate_next_id
    default_pwd = params[:password]
    @user.password_salt = Guid.new.hexdigest
    @user.password_digest = ::Digest::MD5.hexdigest(default_pwd + @user.password_salt)
    @user.mob = params[:mobile]
    @user.save

    @user
    # Sms.delay.send_sms(mobile, Settings.model_type["new_user"], default_pwd)
  end

end
