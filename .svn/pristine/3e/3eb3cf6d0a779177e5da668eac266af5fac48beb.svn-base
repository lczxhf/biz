class ChinaCity
  include Mongoid::Document

  field :name
  field :code

  field :pinyin

  has_and_belongs_to_many :shipping_rules, :class_name => "ShippingRule"

  
  # http://www.stats.gov.cn/tjsj/tjbz/xzqhdm/
  def self.list code=nil
    search = '000000'
    if code.blank? #province
        search = /\d{2}0000/  
    elsif code =~ /^[1-9]\d0000$/  #city
        search = Regexp.new(code[0, 2] + '(\d[1-9]|[1-9]\d)00') 
        #北京市, 天津市, 上海市, 重庆市 直接查询区县
        if ['110000', '120000', '310000', '500000'].index(code.to_s).present? 
            items = ChinaCity.where(code:search).map { |element| element.code[2, 2] }
            search = Regexp.new(code[0, 2] + '(' + items.join('|') + ')' + '(\d[1-9]|[1-9]\d)')
        end
    elsif code =~ /^[1-9]\d(\d[1-9]|[1-9]\d)00$/     #district
        search = Regexp.new(code[0, 4] + '(\d[1-9]|[1-9]\d)') 
    end
    self.where(code:search).where(:name.ne => '市辖区').asc(:order).asc(:code)
  end

end
