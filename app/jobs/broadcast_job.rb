
class BroadcastJob 
  attr_accessor :chanel, :message
  
  def initialize(opts = {})
    @chanel = opts[:chanel]
    @message = opts[:message]
  end

  def perform
    ActionCable.server.broadcast @chanel, message: @message        
  end
end 