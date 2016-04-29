class Admin::Manager 

  include  BaseModel
  
  field :name, type:String
  field :mobile, type:String  

  has_one :admin_user,  autosave:true # 后台管理账号
  has_one :shop     , autosave:true # 多个店铺

  after_create :create_admin_user
  
  def create_admin_user
    G.t "create admin, #{self.mobile}, #{self.name}"

    _admin_user = AdminUser.new
    return if self.mobile.nil?    
    
    pwd = (0..7).map{|p|rand(10)}.join('')
    
    _admin_user.name = "#{self.name}"
    _admin_user.email = "#{self.mobile}@lmoar.com"
    _admin_user.username = "#{self.mobile}"
    _admin_user.password = pwd    
    _admin_user.role = 'manager'
    _admin_user.manager = self
    _admin_user.save    

    Sms.delay.send_sms(self.mobile, Settings.model_type["password"], mobile, pwd)
  end

  def create_emplyee (mob, name)
    admin_user = AdminUser.new    
    
    admin_user.username = mob
    pwd = (0..7).map{|p|rand(10)}.join('')
    admin_user.password = pwd
    admin_user.name = "#{self.name}"    
    admin_user.role = 'emplyee'
    admin_user.manager = self
    admin_user.shop = self.manager.shop
    admin_user.save

    # Sms.delay.send_sms(self.mobile,Settings.send_admin_pwd,pwd)
  end
end
