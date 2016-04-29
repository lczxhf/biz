module G
    class << self

        # 日志输出
        def t params
            msg = "biz log: "
            msg += params.nil? ?  'null' : params.is_a?(String) ? params : params.to_json
            Rails.logger.info(msg)
        end

        def check_mobile(mobile)
            mobile_rule = /^0{0,1}(1[34578])[0-9]{9}$/
            mobile_rule.match(mobile).present?
        end

        def check_email(email)
            email_rule = /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/
            email_rule.match("#{email}").present?
        end

        def check_template_type(template_type)
            return false if template_type.nil?
            Settings.model_type["#{template_type}"].present?
        end

        def create_sms_log(mobile,sms_id,model)
            SmsLog.create!({mob:mobile,out_sn:sms_id,template:model,state:1})
        end

        def is_admin? user
            return false unless user.respond_to? :role
            1 == user.role
        end


    end
end

