class TimedPromotion
  include  BaseModel

  include Mongoid::Search

  field :name

  field :limit_num_per_user, type:Integer, default:1 # 每用户购买数量
  field :limit_period, type:Integer, default: 24  # 每用户限制周期 ,小时

  field :begin_time, type:Time
  field :end_time, type:Time

  search_in :name

  has_many :products

  def as_json
    super(:except => [:_id, :u_at, :c_at, :_keywords])
  end

end
