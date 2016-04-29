class Admin::ExpressController < Admin::ApplicationController

  def index
    @columns = ['_id','name', 'code']    
    do_index
  end

  def new
    @item = Express.new
  end

  def create
    @item = Express.new(params[:express].to_hash)
    @item.save!
    
    redirect_to ace_path @item
  end

  def edit
    @item = Express.find(params[:id])
  end

  def update
    @item = Express.find(params[:id])
    @item.update_attributes(params[:express].to_hash)

    redirect_to ace_path @item
  end

end
