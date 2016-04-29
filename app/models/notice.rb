class Notice
  include  BaseModel

  belongs_to :admin_user

  field :content
  field :event_count, default:0 #事件条数

  belongs_to:user
  belongs_to:order
  belongs_to:order_product_comment

  field :read, type:Boolean, default: false

  field :event_type, type:Integer
  field_display :event_type, {0 => "新订单", 1=>"发货提醒", 2 => "收货提醒", 3 => '产品评价', 4 => '新用户注册', 5 => '新商家', 6 => '新促销服务', 7 => '新促销产品组'}

  scope :unread, ->{where(read:false)}

  #查找或者创建 属于某个admin_user的 类型未tp的 未读通知
  #参数 tp 通知类型  user： 管理员
  #返回  notice
  def self.get_ongoing_notice( tp, user)
    Notice.find_or_create_by(event_type:tp, read:false, admin_user: user)
  end

  #发送通知，如果此类型，此管理员，未读的通知存在那么事件数加1
  #否则就是创建新的
  def self.notify(tp, count=1)

    AdminUser.all.each do |admin_user|
      notice = Notice.get_ongoing_notice tp, admin_user 
      notice.event_count += count
      notice.save  
    end
    
  end

  #根据通知事件返回对应处理的controller名称
  def show_controller
    case event_type
    when 0..2
      return 'order'
    when 3
      return 'order_product_comment'
    when 4
      return 'user'
    when 5
      return 'shop'
    when 6
      return 'sale_activity'    
    when 7
      return 'sale_group'
    end
  end

end
