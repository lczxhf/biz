class Article
  include  BaseModel
  include Mongoid::Search

  field :name, type: String		#名称
  field :brief, type: String  	#简介
  field :position, type: Integer # 排序

  field :content				#内容

  has_one :picture

  field :state, type: Integer, default: 0
  field_display :state, {0 => '待审核', 1 => '上线', 2 => '下线'}

end
