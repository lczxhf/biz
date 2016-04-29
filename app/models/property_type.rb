class PropertyType
  include  BaseModel
  #属性/标签表
  field :name, type: String
  field :option_values  

  has_and_belongs_to_many :property_type_prototypes
  has_many :product_property_types
end
