class OptionType
  include  BaseModel
  #商品规格表
  field :name, type: String
  has_many :option_values
  
  has_and_belongs_to_many :products
end
