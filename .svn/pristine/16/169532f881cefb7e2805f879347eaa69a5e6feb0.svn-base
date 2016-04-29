class PromotionRule
  include  BaseModel

  field :name

  # field :state, type:Integer
  # field_display :state, { 0 => '上线', 1 => '下线'}

  field :begin_time, type:Time
  field :end_time, type:Time

  field :type, type:Integer
  field_display :type, { 0 => '满减现金', 1 => '购物送券'}

  field :threshold, type:Integer
  field :value, type:Integer

  has_many :products

  def online?
    now = Time.now
    begin_time < now and end_time > now
  end

  def self.get_discount_by (order_products)
    rules = order_products.map(&:variant).map(&:product).map(&:promotion_rule).uniq

    ret = {cash_discount:0, reward_score:0}

    cash_discount = reward_score = 0
    rules.each do |rule|
      next if rule.nil?
      
      sum = 0
      order_products.select{|op| op.variant.product.promotion_rule.nil? ? false: op.variant.product.promotion_rule.id == rule.id}.each do |op|
        sum += op.price.to_i * op.num.to_i
      end

      cash_discount += sum / rule.threshold.to_i * rule.value.to_i if rule.type == 0
      reward_score += sum / rule.threshold.to_i * rule.value.to_i if rule.type == 1
      
    end

    ret[:cash_discount] = cash_discount
    ret[:reward_score] = reward_score
    ret
  end

end
