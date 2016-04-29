#
class OptionTypePrototype
  include  BaseModel

  field :name, type: String  
  has_and_belongs_to_many :option_types
end
