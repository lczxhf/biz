class ValidateCode
  include  BaseModel
  
  field :dest
  field :code
  field :template, type:Integer  # 模板id
  field :is_verify, type:Boolean, default:false
  
  def getTemplateName

    case template
    when 12777
      return '注册'
    when 12776
      return '绑定'
    when 12775
      return '登录'
    end

    template
    
  end
end
