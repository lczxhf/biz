class LotteryOrder
  include  BaseModel

  belongs_to :user    

  field :province
  field :city
  field :dist
  field :street
  field :zipcode
  field :trade_no
  field :real_amount 

  field :pay_state, type:Integer, default:0 
  field_display :pay_state, {0=>"待付款", 1=>"已支付", 2 => "已退款" }  

  scope :pay_record , -> {where(pay_state:1)}
  field :pay_time, type:Time
  field :user_ip, type:String

  field :ip2address, type:String  # by ip
  has_many :lottery_order_items,dependent: :destroy  # 可能包括多种奖品

  after_create :get_ip2address

  def address= (address)
    %w(consignee mobile province city street zipcode).each do |name|
      write_attribute name, address.send(name.to_sym)
    end
  end


  def can_pay?
    return false if pay_state > 0

    self.lottery_order_items.each do |item|
      return false unless (item.can_pay? && item.lotteries.present?)
    end

    true
  end

  def before_pay
     already_create = true
      self.lottery_order_items.each do |item|
        if item.lotteries.empty?
          already_create = false
          if !item.lock_lottery
              rollback_lottery
              return false
          end
        else
           return false
        end
      end

      delay(run_at: 2.minutes.from_now).check_pay_state unless already_create

      true
  end

  def check_pay_state
      if pay_state != 1
        lottery_order_items.each do |item|
            item.unlock_lottery
        end
      end
  end

  def rollback_lottery
      LotteryOrderItem.rollback_lottery self.lottery_order_items.map {|item| item.id}
  end

  def total_price
      self.lottery_order_items.inject(0) {|result,item| result + item.num}
  end
  #用户支付完成
  def on_pay_done(real_amount, trade_no)
    self.update_attributes(pay_state:1, real_amount:real_amount, trade_no:trade_no, pay_time:Time.now)
    self.lottery_order_items.each{|item| item.on_pay_done}

    
  end  

  def set_user_ip(ip)
      self.user_ip = ip
  end

  def self.delete_invalid_order
        orders = LotteryOrder.where(pay_state:0)
        orders.each do |order|
          break unless Lottery.where(used:2).in(lottery_order_item_id:order.lottery_order_items.map{|a| a.id}).empty?
           order.destroy!
        end

  end

  #订单创建时获取
  def get_ip2address
    url = "http://ip.taobao.com/service/getIpInfo.php?ip=#{self.user_ip}"
    res = (JSON.parse RestClient.get url).to_hash

    if res['code'] == 0
     self.ip2address = "#{res['data']['region']}#{res['data']['city']}"
     save
    end   
  end

  handle_asynchronously :get_ip2address


end



