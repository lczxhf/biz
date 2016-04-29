class OptionValue 
  include  BaseModel
  
  field :name, type: String, default:"默认"
  field :position, type: Integer

  belongs_to :option_type
  has_and_belongs_to_many :variant
end
