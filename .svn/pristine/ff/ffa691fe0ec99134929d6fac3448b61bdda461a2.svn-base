class ProductPropertyType
  include Mongoid::Document

  field :value , default:'默认'
  belongs_to :product
  belongs_to :property_type

  def name
    property_type.name
  end

  def option_values
    property_type.option_values
  end
end
