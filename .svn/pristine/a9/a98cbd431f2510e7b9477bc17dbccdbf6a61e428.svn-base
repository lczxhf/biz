
module BaseModel
  # include Mongoid::Document
  # include Mongoid::Timestamps::Short      
  # include BizModule

  module InstanceMethods    
    def as_json(options={})
      super(:except => [:_keywords])
    end
  end

  def self.included(receiver)
    receiver.send :include,  InstanceMethods
    receiver.send :include,  Mongoid::Document
    receiver.send :include,  Mongoid::Timestamps::Short      
    receiver.send :include,  BizModule
  end

end
