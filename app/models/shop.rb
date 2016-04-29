class Shop
  include  BaseModel
  include Mongoid::Search

  field :province #, default:"广东省"
  field :city      #, default:"深圳"
  field :dist
  field :street

  field :name  ,type:String
  field :mobile   ,type:String
  field :contactor,type:String
  field :rating, type:Float, default:5.0

  # has_and_belongs_to_many :car_brands, class_name:"CarBrand"

  field :loc, type: Array, default: [ 22.545311, 114.067262]  # [lng, lat] 
  index({loc: '2d'}, { min: -180, max: 180 })

  field :content

  has_many :photos

  has_many :order_product_comments

  has_many :admin_users ,dependent: :destroy# 后台管理账号
  belongs_to  :manager, class_name: "Admin::Manager"  

  search_in :name, :city, :dist, :street

  field :state, type:Integer, default:0 # 0:待审核 1：正常 100：已删除  status =1 才能正常在网页上显示
  field_display :state, { 0 => '待审核' , 1 => '正常',  100 => '已删除'}

  scope :wait_confirm, ->{where(state:0)}
  scope :normal, ->{where(state:1)}
  scope :deleted, ->{where(state:100)}

  default_scope ->{where(:state.lt => 2)}

  after_create :create_manager

  def create_manager
    return if self.mobile.nil?

    _manager = Admin::Manager.new
    _manager.name = "#{self.contactor}"
    _manager.mobile = self.mobile    
    self.manager = _manager
    _manager.save
    self.save    

    create_notice
  end

  def basic_comments
    OrderProductComment.desc(:created).limit(3)    
  end

  def create_notice
    Notice.notify 5
  end

  def as_json(options={})
    super(:except => [:content, :created_at, :updated_at, :_keywords, :car_brand_ids, :manager_id])      
  end

  def full_address
    "#{province}#{city}#{dist}#{street}"
  end

end
