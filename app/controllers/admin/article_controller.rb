class Admin::ArticleController < Admin::ApplicationController
  def index
    @columns = ['_id','name', 'brief', 'position', 'state', 'updated_at']
    do_index
  end

  def show
    @item = Article.find_by_id(params[:id])    

  end

  def new
    @item = Article.new
  end

  def create
    _params = params[:article]    
    pic_ids = params[:pic_id].split(',').select {|item| item.present?}    
    
    @item = Article.new(_params.to_hash)    

    if @item.save! 

      Picture.where(:id.in=>pic_ids).update_all(article_id: @item.id)        
      redirect_to  ace_path @item
    else
      redirect_to ace_path_index @item
    end

  end

  def update
    @item = Article.find_by_id(params[:id])    

    _params = params[:article].to_hash

    pic_ids = params[:pic_id].split(',').select {|item| item.present?}
    Picture.where(:id.in=>pic_ids).update_all(article_id: @item.id)    

    @item.update_attributes(_params)   
    redirect_to ace_path_index @item 

  end

  def edit
    @item = Article.find_by_id(params[:id])    
  end

  
end
