class Admin::OptionTypePrototypeController < Admin::ApplicationController
  include Admin::ApplicationHelper

  def index    
    @columns = ['_id','name', 'fields', 'u_at']
    do_index
  end

  def new
    @item = OptionTypePrototype.new
  end

  def create
    need_params =  params[:option_type_prototype].to_hash
    @item = OptionTypePrototype.create  need_params    
    redirect_to ace_path_index @item
  end

  def update
    @item = OptionTypePrototype.find_by_id params[:id]
    need_params =  params[:option_type_prototype].to_hash
    @item.update_attributes need_params
    redirect_to ace_path_index @item
  end

  def edit
    @item = OptionTypePrototype.find_by_id params[:id]

  end
end
