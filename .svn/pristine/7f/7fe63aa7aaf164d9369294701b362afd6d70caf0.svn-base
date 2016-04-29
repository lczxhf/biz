class UserAddress
  include  BaseModel
  include Mongoid::Search
  
  field :consignee , type:String
  field :mobile  , type:String

  field :province, type:String
  field :city, type:String
  field :dist, type:String
  field :street  , type:String
  field :zipcode, type:String

  # field :best_time
  
  field :is_default, default:false #1 =>默认地址
  
  belongs_to :user
  
  has_many :temp_orders

  search_in :mobile, :street, :consignee  


  def as_json(options={})
    super(:except => [:user_id, :_keywords])
  end

end
