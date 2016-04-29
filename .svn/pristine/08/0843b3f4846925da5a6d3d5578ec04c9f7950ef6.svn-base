class Admin::SalesManController < Admin::ApplicationController

  def index
    @columns = ['_id','name', 'mobile', 'updated_at']    
    do_index
  end

  def new
    @item = SalesMan.new
  end

  def create
    @item = SalesMan.new(params[:sales_man].to_hash)
    @item.save!
    
    redirect_to ace_path @item
  end

  def edit
    @item = SalesMan.find(params[:id])
  end

  def update
    @item = SalesMan.find(params[:id])
    @item.update_attributes(params[:sales_man].to_hash)

    redirect_to ace_path @item
  end

end
