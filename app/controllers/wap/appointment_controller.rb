class Wap::AppointmentController < Wap::ForceLoginController

  def new
    @title = '我要预约'
    @product = Product.find params[:product_id]
  end


  def create
    @item = Appointment.new(params[:appointment].to_hash)
    @item.save!

    render json:{result_code: 0} and return
  end

  def index
    @title = '我的预约'
    @items = Appointment.where(user:@current_user)    
  end

end
