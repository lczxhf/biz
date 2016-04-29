module BSON
  class ObjectId
    def to_json(*args)
      to_s.to_json
    end

    def as_json(*args)
      to_s.as_json
    end
  end
end


class Time
  def to_hms
    strftime("%y-%m-%d %H:%M:%S")
  end

  def to_digital
    strftime("%H%M%S%L").to_i
  end

end

require 'ostruct'

class Hash
  def to_ostruct
    OpenStruct.new self
  end
end