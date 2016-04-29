#encoding:utf-8
require 'ucpaas'

module Sms
  class << self
    def send_sms(mobile, model, *sms_params)   #手机号 ,对应云之讯的model_id,短信参数(如需2个参数则是＇params1,params2＇)
      G.t mobile:mobile, model:model, sms_params:sms_params.to_a.to_s

      client = Ucpaas::Client.new Settings.accountSid, Settings.token
      
      begin
        # response =  client.send_sms  Settings.appid ,model, mobile, sms_params
        # return_data = JSON.parse response.body

        G.create_sms_log(mobile,model,sms_params)
        G.t "return_data=>#{return_data}"        

      rescue =>err
        return nil
      end
    end

  end
end
