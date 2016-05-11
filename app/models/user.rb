
class User
  include  BaseModel
  include Mongoid::Search
  
  mount_uploader :avatar, PictureUploader

  field :name, type: String    
  field :mob, type: String
  field :level, type: Integer, default: 4
  field :wx_openid, type: String  #weixin openid

  field :avatar

  field :password_salt
  field :password_digest
  field :client_ip, type:String

  field :score, type: Integer,  default: 0
  
  has_many :cart_line_items, :autosave => true, dependent: :destroy
  has_many :lottery_cart_items, :autosave => true, dependent: :destroy
  has_many :lottery_orders,:autosave => true, dependent: :destroy
  has_many :order_product_comments, dependent: :destroy
  has_many :lotteries,dependent: :destroy
  # has_many :comments , dependent: :destroy  

  has_one :temp_order, class_name:"TempOrder", dependent: :destroy

  has_many :orders, :order => 'state asc,u_at desc'
  has_many :user_addresses, :order => "u_at desc"

  has_many :user_message, dependent: :destroy
  has_many :visit_product_records, :class_name => "VisitProductRecord"
  has_many :favorite_products, class_name:"FavoriteProduct"
  has_many :coupons, dependent: :destroy
  has_many :appointments

  has_many :prize_comments

  field :state, type: Integer, default: 1
  field_display :state, {1 => '正常', 2 => '待验证', 100 => '已删除'}

  field :type, type: Integer, default: 1
  field_display :type, {0 => '临时', 1 => '普通', 2 => '微信'}

  search_in :name, :nickname, :mob, :email, :qq

  scope :normal,  ->{where(state:1)}
  scope :temp, ->{where(type:0)}

  def password=(password)
    self.password_salt = Guid.new.hexdigest
    self.password_digest = ::Digest::MD5.hexdigest(password + self.password_salt)
    self.save
  end
  
  def authenticate(password)
    ::Digest::MD5.hexdigest(password<<self.password_salt) == self.password_digest    
  end

  def create_user
    if self.name.nil?
      self.update_attributes name:self.mob if self.mob.present?
      self.update_attributes name:self.email if self.name.nil?
      self.update_attributes name:self.nickname if self.name.nil?
    end
  end

  def as_json(options={})
    super(:except => [:_keywords, :password_digest, :password_salt, :state])
  end

  def temp?
    type == 0
  end

  def merge_tmp_user tmp_user
    if tmp_user
      CartLineItem.where(user: tmp_user).update_all(user_id: self.id)
      LotteryCartItem.where(user: tmp_user).update_all(user_id: self.id)
      tmp_user.delete
    end
  end

  def is_tmp?
    type == 0
  end

  def self.delete_tmp_user
    time = 3.days.ago(Time.now)
    User.where(type:0,:u_at.lt => time).delete_all
  end

end
