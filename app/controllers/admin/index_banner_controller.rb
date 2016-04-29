class Admin::IndexBannerController < Admin::ApplicationController

  def index
    @columns = ['_id','name', 'desc', 'position', 'updated_at']    
    do_index
  end

  def new
    @item = IndexBanner.new
  end

  def create
    _params = params[:index_banner]
    pic_ids = params[:pic_id].split(',').select {|item| item.present?}  

    @item = IndexBanner.new(_params.to_hash)    

    if @item.save! 
      Picture.where(:id.in=>pic_ids).update_all(index_banner_id: @item.id)        
      redirect_to  ace_path @item
    else
      redirect_to ace_path_index @item
    end

  end

  def edit
    @item = IndexBanner.find params[:id]
  end

  def update
    @item = IndexBanner.find params[:id]

    _params = params[:index_banner].to_hash

    pic_ids = params[:pic_id].split(',').select {|item| item.present?}
    Picture.where(:id.in=>pic_ids).update_all(index_banner_id: @item.id)    

    @item.update_attributes(_params)   
    redirect_to ace_path_index @item 
  end


end
