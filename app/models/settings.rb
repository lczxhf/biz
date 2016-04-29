#encoding:utf-8
class Settings < Settingslogic
  # include Mongoid::Document
  source "#{Rails.root}/config/settings.yml"
  namespace Rails.env
end



