class IndexBanner
  include  BaseModel

  field :name, type:String
  field :desc, type:String
  field :link, type:String

  field :position, type:Integer # 排序
  has_one :picture

end
