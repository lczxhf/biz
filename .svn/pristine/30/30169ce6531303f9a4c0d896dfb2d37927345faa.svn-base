class Category
  include  BaseModel
  include Mongoid::Search

  field :name, type: String
  field :code, type: String  
  field :brief, type: String      #简介
  field :position, type: Integer # 排序

  has_many :products
  has_one :picture, :class_name => "::Picture"


  field :parent, type:String
  field :level, type:Integer, default:0
  before_save :calc_level

  #获取某个分类以及所有子分类的的信息
  #返回： {{}}
  def get_tree
    _children = self.children.map do |i|
      result = i.get_tree
      # if result["children"]
      #   result
      # else
      #   {text: i.name, id: i.id, folder: true}
      # end
    end
    {text:self.name, id:self.id, children: _children, folder: true}
  end

  #返回所有分类的名称和id,并在最前面添加["空", "0"]
  #返回： Array[Array]
  def self.make_select_items
    self.asc(:level).map { |e| [e.name, e.id.to_s] }.unshift ["空", "0"]
  end
  
  #根据parant 计算这个分类的level应该是多少！
  #返回 integer
  def calc_level        
    self.level = 1 + parent_obj.level  unless parent_obj.nil?    
  end

  #获取某一分类的上一级
  def parent_obj
    Category.where(id: self.parent).first
  end

  #获取某一分类的子类
  def children
    Category.where(parent: self.id.to_s) || []
  end

  def  descendant
    ret = [self]

    Category.each do |cat|
      ret << cat if cat.ancestors.include? self
    end

    ret.flatten.uniq
  end

  def ancestors
    ret = [self]
    if parent_obj      
      ret.push parent_obj.ancestors
    end

    ret.reverse.flatten
  end

  #返回分类里与次分类同一父类 同一level的分类集合
  # Array[category]
  def brothers
    Category.where(parent:self.parent, level:self.level).reject {|item| item.id == self.id} || []
  end

  #获取所有分类里 level最大的
  def self.max_level
     Category.all.map {|i| i.level}.uniq.max
  end

  #获取默认的分类
  #返回 Array[category]
  def self.default    
    root = Category.where(level:0).first
    ret = []

    while root
      ret.push root
      root = root.children.first
    end
    ret
  end

  def as_api_json
    children_json = []
    self.children.each do |c|
      children_json.push c.as_api_json
    end

    value = {category_id:self.id, name:name}
    value["children"] = children_json unless children.empty?
    value[:photo] = self.picture.url(:thumb) if picture

    value
  end

  def soft_delete!
    destroy!
  end
  
end
