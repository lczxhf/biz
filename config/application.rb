require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "action_cable"
require "action_cable/engine"
# require "rails/test_unit/railtie"


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Biz
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    
    config.middleware.delete Rack::Lock  #temp

    config.i18n.default_locale = :"zh-CN"
    config.i18n.locale = :"zh-CN"

    config.time_zone = 'Chongqing'
    config.active_job.queue_adapter = :delayed_job
    config.middleware.use Rack::RawUpload

    # config.mongoid.observers = :model_observer

    config.exceptions_app = self.routes

    config.encoding = "utf-8"

    Mongo::Logger.logger = ::Rails.logger

    config.generators do |g|
      # g.test_framework  nil #to skip test framework
      g.assets  false
      g.helper false
      g.stylesheets false

      g.test_framework :rspec,
        :fixtures => true,
        :view_specs => false,
        :helper_specs => false,
        :routing_specs => false,
        :controller_specs => true,
        :request_specs => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end

  end
end
