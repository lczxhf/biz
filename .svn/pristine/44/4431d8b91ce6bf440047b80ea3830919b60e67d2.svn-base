class Admin::PropertyTypePrototypeController <  Admin::ApplicationController
  include Admin::ApplicationHelper

  def index    
    @columns = ['_id','name', 'fields', 'u_at']
    do_index
  end

  def new
    @item = PropertyTypePrototype.new
  end

  def create
    need_params =  params[:property_type_prototype].to_hash
    @item = PropertyTypePrototype.create  need_params    
    redirect_to ace_path_index @item
  end

  def update
    @item = PropertyTypePrototype.find params[:id]
    need_params =  params[:property_type_prototype].to_hash
    @item.update_attributes need_params
    redirect_to ace_path_index @item
  end

  def edit
    @item = PropertyTypePrototype.find params[:id]

  end

end
