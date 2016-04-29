class OrderRecord 
  include  BaseModel
  
  field :action_note
  field :client_ip
  
  field :state
  field :pay_state
  field :shipping_state
  
  belongs_to :order, class_name:"Order"
  belongs_to :admin_user, class_name:"AdminUser"  
end
