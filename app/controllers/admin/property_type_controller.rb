class Admin::PropertyTypeController <  Admin::ApplicationController
  include Admin::ApplicationHelper

  def index    
    @columns = ['_id','name', 'option_values', 'u_at']
    do_index
  end

  def new
    @item = PropertyType.new    
  end

  def create
    need_params =  params[:property_type].to_hash
    need_params["option_values"].gsub!('，', ",")

    @item = PropertyType.create  need_params    
    redirect_to ace_path_index @item
  end

  def edit
    @item = PropertyType.find params[:id]
  end

  def update
    @item = PropertyType.find params[:id]
    need_params =  params[:property_type].to_hash
    need_params["option_values"].gsub!('，', ",")

    @item.update_attributes need_params

    redirect_to ace_path @item
  end

end
