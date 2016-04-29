class Api::SessionController < ApplicationController
  include Api::SessionHelper
  include Api::BaseHelper

  before_filter :check_params, except: [:register, :back_password, :logout]
  before_filter :check_id_uniq, only: [:register]

  def register
    expire_time = Settings.sms_expire_time.to_i # 短信失效时间 second
    record = ValidateCode.where(dest: params[:mobile], template: Settings.model_type['reg'], is_verify: false).desc('c_at').first

    if record.nil? # 数据库无记录
      G.t 'no code find'
      render json:  json_error(Settings.db_code_err)
      return
    end
    
    Rails.logger.info("session_controller_updated_at=>#{expire_time.minutes.ago(record.updated_at)}")

    if expire_time.minutes.since(record.updated_at) < Time.now
      render json:  json_error(Settings.verify_code)
      return
    end

    if params[:code].to_s != record.code # 验证码不匹配
      render json:  json_error(Settings.verify_code_err)
      return
    end

    record.update_attributes!(is_verify: true)
    user = create_new_user(params)
    create_session user
    # Notice.notify 4

    render json: { result_code: Settings.success}.to_json
  end

  def get_sms # 发短信
    mobile = params[:mobile]

    if mobile && G.check_mobile(mobile) # 检测手机号合法,并发送手机短信

      if User.where(mob: mobile).first.present? && params[:template_type] == 'reg'
        render json:  json_error(Settings.reg_id_exist)
        return
      end

      template_type = params[:template_type] # 检验短信model是否存在
      template_flag = G.check_template_type(template_type)
      unless template_flag
        render json: json_error(Settings.err_model)
        return
      end

      # mobile = @curren_user.mob if params[:template_type] == 'bind'

      send_sms(mobile, params[:template_type])
    end

    render json: { result_code: Settings.success }
  end


  def login
    result_code = Settings.login_faild

    if params[:mobile].present?
      @user = User.where(mob:params[:mobile]).first
    end

    if @user.nil?  # 用户不存在
      result_code = Settings.user_not_exist
    elsif params[:password].present? # 账号和密码登录
      pwd = ::Digest::MD5.hexdigest(params[:password].to_s << @user.password_salt)
      result_code = Settings.success if pwd == @user.password_digest
    elsif params[:code].present? # 验证码登录
      expire_time = Settings.sms_expire_time.to_i.minutes.ago(Time.now)
      record = ValidateCode.where(dest: params[:mobile], template: Settings.model_type['login'], is_verify: 0, code:params[:code], :updated_at.gte=>expire_time).desc('updated_at').first
      if record.present?
        result_code = Settings.success
        record.update_attributes!(is_verify: 1)
      else
        result_code = Settings.verify_code
      end
    end
    # G.t "result_code: #{result_code}"    

    if result_code == Settings.success # 登录成功
      create_session @user
      render json: { result_code:result_code , user:@user}  
      return
    end

    render json: { result_code:result_code , error_message: Settings.send("info_#{result_code}")}
  end
 

  def back_password
    Rails.logger.info("session_controller_send_reg_email=>#{params}")
    result_code = Settings.user_not_exist

    unless params[:mobile].nil?
      unless User.where(mob: params[:mobile]).nil?
        code = rand(999_999)
        sms_params = "#{code},#{Settings.sms_expire_time}"
        Sms.delay.send_sms(params[:mobile], Settings.reset_password, sms_params)
        result_code = Settings.success
      end
    end

    unless params[:email].nil?
      unless User.where(email: params[:email]).nil?
        ##
        # 通过邮件发送新密码
        return
      end

    end
  end

  def logout
    session[:user_id] = nil if session[:user_id].present?
    render json: { result_code: Settings.success }
  end

  def er_wei_ma
    str = 'http://www.baidu.com'
    qr = RQRCode::QRCode.new(str)
    require 'rqrcode/export/png'
    response.headers['Cache-Control'] = "public, max-age=#{12.hours.to_i}"
    response.headers['Content-Type'] = 'image/png'
    response.headers['Content-Disposition'] = 'inline'
    render :text => qr.as_png
  end

  private

  def check_params
    mobile = params[:mobile]        
    mobile_flag = G.check_mobile(mobile)
    
    unless mobile_flag
      Rails.logger.info("check_params_params=>#{Settings.info_10010}")
      render json: { result_code: Settings.illegal_mob, error_message: Settings.info_10010}.to_json
    end
  end

  def check_id_uniq
    # Rails.logger.info("session_controller_register_check_id_uniq=>#{params}")
    mobile = params[:mobile]

    if User.where(mob:mobile).empty? == false
      G.t "reg_id_exist"
      render json: { result_code: Settings.reg_id_exist, error_message: Settings.info_10040 }.to_json
      return
    end
  end

  def create_session curren_user
    user_id = session[:user_id]
    G.t "tpm user_id -> #{user_id}"
    tmp_user = user_id.nil? ? nil : User.find_by_id(user_id)
    
    curren_user.merge_tmp_user tmp_user
    session[:user_id] = curren_user.id
    # session[:expire_at] = 10000.minutes.since(Time.now)
  end


end
