class Product
  include  BaseModel
  include Mongoid::Search    

  field :name, type: String
  field :brief, type: String    #文字说明  

  field :is_hot, type:Boolean, default:false  #是否热销

  field :state, type: Integer, default: 0
  field :score, type: Integer, default: 0 #用户购买时赠送的积分

  field_display :state, {0 => '待审核', 1 => '已上架', 2 => '下架', 100 => '删除'}

  field :content #html string

  field :rating, type:Float, default:4.5

  field :price, type:Float

  field :sell_count, default:1     #售出多少件
  field :view_count, default:1     #访问次数

  search_in :name, :content , :category => :name

  field :has_warranty, type:Boolean, default:true  #保修
  field :has_invoice, type:Boolean, default:true   #发票
  field :sell_promise ,type:Boolean, default: true #退换货承诺
  field :newprepay, type:Boolean, default:true     #7天无理由退货

  has_many :variants,  dependent: :destroy  
  has_many :product_property_types,  dependent: :destroy
  has_and_belongs_to_many :shipping_rules
  has_one :index_banner
  has_many :appointments
  
  belongs_to :category  

  belongs_to :property_type_prototype

  has_and_belongs_to_many :default_option_types, class_name:"OptionType"
  
  belongs_to :timed_promotion
  belongs_to :promotion_rule
  belongs_to :tag

  has_many :favorites, class_name:"FavoriteProduct"

  field :has_assemble_fee, type:Boolean, default:false  #安装
  field :assemble_fee, type:String  #安装费说明

  scope :online, ->{ where(state: 1) }    
  default_scope ->{ where(:state.lt => 2) }

  after_update :update_self
  after_create :init_variant
  #update回调
  def update_self
    #判断是否修改了属性
    if property_type_prototype_id_changed?

      product_property_types.delete_all

      property_type_prototype.property_types.each do |p|        
        ProductPropertyType.create(product: self, property_type: p)
      end
    end
    #判断是否修改了规格
    if default_option_type_ids_changed?
      variants.delete_all
      create_variants
    end

    #判断规格是否为空
    if variants.empty?
      Variant.create(price:self.price, product:self)
    end

    # 判断是否修改了价格
    if price_changed?
      variants.update_all price:self.price
    end

  end

  #create回调
  def init_variant
    #判断规格是否修改
    if default_option_type_ids.empty?

      opt_value = OptionValue.find_or_create_by(name:"默认")
      opt_type = OptionType.find_or_create_by(name:"规格")
      opt_value.option_type_id = opt_type.id
      opt_value.save

      v = Variant.create(price:self.price, product:self)
      v.sku = "#{self.id}-#{v.id}"
      v.option_values << opt_value
      v.save
    else
      create_variants
    end
    #判断是否添加了属性
    if property_type_prototype.present?

      property_type_prototype.property_types.each do |p|        
        ProductPropertyType.create(product: self, property_type: p)
      end
    end
  end

  #创建商品的variant
  def create_variants
    combines = default_option_types.first.option_values.map(&:id)
    # G.t combines
    default_option_types[1..default_option_types.length].each do |type|
      combines = combines.product type.option_values.map(&:id)
    end
    
    combines.each_with_index do |opt_values, index|
      # G.t opt_values#.flatten
      v = Variant.create(price:self.price, product:self,  option_value_ids: (([]<<opt_values).flatten))
      v.sku = "#{self.id}-#{v.id}"
      v.save
    end
  end
  
  #返回variant的文本形式
  #Array[Array[string]]
  def combine_arrays(*arrays)
    if arrays.empty?
      yield
    else
      first, *rest = arrays
      first.map do |x|
        combine_arrays(*rest) {|*args|  yield x, *args }
      end.flatten
    end
  end

  def get_photos
    variants.map(&:photos).flatten
  end

  def option_types
    variants.first.option_values.asc(:name).map(&:option_type)
  end

  def have_options?
    self.variants.count > 1
  end

  def stock
    variants.map(&:stock).inject(&:+)
  end

end
