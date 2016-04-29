module BizModule
  module ClassMethods
    #设置根据id来查找！
    def find_by_id(id)
      if id.is_a?(Integer) or id.is_a?(String)
        where(:_id => id.to_s).first
      else
        nil
      end
    end

    #存储Model里一些描述状态字段的 数值与文字说明对应
    #参数：字段名  Hash
    #返回：存储的容器（Hash）
    def field_display(field, hs)
      @hash_container = Hash.new if @hash_container.nil?
      @hash_container[field.to_s] = hs
    end

    #根据文字说明或者 字段的 数值表示
    #参数： 字段名
    #返回： [[String,integer]]
    def get_field_display field
      items = @hash_container[field.to_s]
      if items.is_a? Hash
        items.invert.to_a
      else
        []
      end
    end

    #返回Model里状态类的字段的值对应的解释
    #参数： 字段名  字段的值
    #返回string
    def class_kv_enum(field, value)
      @hash_container[field.to_s][value]
    end

  end

  module InstanceMethods    

    #返回某个model对象的某字段的值对应的解释
    #参数 字段名
    #返回 String
    def get_display(field)
      items = self.class.get_field_display field
      value = self.send field

      kv = items.select{|(display, v)| v == value}
      return value if kv.blank?
      kv.first.first
    end

  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end

  #返回拼接起来的地址
  def readable_address
    str = ""

    p = ChinaCity.where(code:province).first
    p = p.name if p



    c = ChinaCity.where(code:city).first 
    c = c.name if c

    d = ChinaCity.where(code:dist).first 
    d = d.name if d

    p ||= ''
    c ||= ''
    d ||= ''
    detail = street
    detail ||= ''


    str << p << c << d << detail   
    str
  end
end