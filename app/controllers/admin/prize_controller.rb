class Admin::PrizeController < Admin::ApplicationController

  def index    
    @columns = ['_id','name','total_share', 'sale_unit', 'updated_at']
    do_index
  end

  def new
    @item = Prize.new
  end

  def show
    @item = Prize.find_by_id params[:id]
  end

  def edit
    @item = Prize.find_by_id params[:id]
  end

  def update
    @item = Prize.find_by_id params[:id]

    _params = params[:prize].to_hash

    pic_ids = params[:pic_id].split(',').select {|item| item.present?}
    Picture.where(:id.in=>pic_ids).update_all(prize_id: @item.id)    

    @item.update_attributes(_params)   
    redirect_to ace_path_index @item 
  end

  def create
    _params = params[:prize]    
    pic_ids = params[:pic_id].split(',').select {|item| item.present?}    
    
    @item = Prize.new(_params.to_hash)    

    if @item.save! 

      Picture.where(:id.in=>pic_ids).update_all(prize_id: @item.id)        
      redirect_to  ace_path @item
    else
      redirect_to ace_path_index @item
    end

  end

end
