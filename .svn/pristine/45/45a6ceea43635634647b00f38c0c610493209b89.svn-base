class Admin::PrizeActivityController < Admin::ApplicationController

  def index    
    @columns = ['_id','name','total_share', 'saled_share', 'begin_time', 'updated_at']
    do_index
  end

  def new
    @item = PrizeActivity.new
  end

  def show
    @item = PrizeActivity.find_by_id params[:id]
  end

  def edit
    @item = PrizeActivity.find_by_id params[:id]
  end

  def update
    @item = PrizeActivity.find_by_id params[:id]

    _params = params[:prize_activity].to_hash

    @item.update_attributes(_params)   
    redirect_to ace_path_index @item 
  end

  def create
    _params = params[:prize_activity]    
    @item = PrizeActivity.new(_params.to_hash)

    if @item.save! 
      redirect_to  ace_path @item
    else
      redirect_to ace_path_index @item
    end

  end

end
