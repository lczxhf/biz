#encoding:utf-8


APP_ID = 'wx0b74198ac2211b98'
APP_SEC = 'eb922936c366c194f79ac3133c8cc208'
MCH_ID = '1229077102'
PAY_KEY = '25bd40fe01071541f869dabbd8a582cf'


def initWeixinParams
    #################### wx_pay ###################
    WxPay.appid = APP_ID
    WxPay.key = PAY_KEY
    WxPay.mch_id = MCH_ID

    WxPay.extra_rest_client_options = {timeout: 2, open_timeout: 3}
    
    ################# weixin_authorize ################
    namespace = "biz:weixin_authorize"
    redis = Redis.new(:host => "127.0.0.1", :port => "6379", :db => 15)
    Redis.current = redis

    # 每次重启时，会把当前的命令空间所有的access_token 清除掉。
    exist_keys = redis.keys("#{namespace}:*")
    exist_keys.each{|key|redis.del(key)}

    redis = Redis::Namespace.new("#{namespace}", :redis => redis)

    WeixinAuthorize.configure do |config|
      config.redis = redis
    end

    $wx_client ||= WeixinAuthorize::Client.new(APP_ID, APP_SEC, redis_key:"biz_wx_authorize")
    G.t 'wx_client init fail'  unless $wx_client.is_valid?
end


if Rails.env == 'development'
    # 开发环境下，不参与微信开发，可不启动redis
    begin   
        initWeixinParams
    rescue Exception => e
        p "redis init falid"
        p e
    end
else
    initWeixinParams
end
