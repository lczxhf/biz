class SalesMan
  include  BaseModel
  include Mongoid::Search

  field :name, type:String
  field :mobile, type:String  #英文

  has_many :appointments
end
