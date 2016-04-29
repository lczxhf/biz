class Admin::CategoryController < Admin::ApplicationController
  include Admin::ApplicationHelper

  def index
    @cats = Category.where(level: 0)
    @opts[:hide_batch_action] = true
    
    if @cats.count > 0
      return render 'index',layout: 'admin'
    end

  end

  def show
    @item = Category.find(params[:id])     
  end


  def edit
    @item = Category.find(params[:id])
  end


  def update
    @item = Category.find(params[:id])    

    _params = params[:category].to_hash

    pic_ids = params[:pic_id].split(',').select {|item| item.present?}
    Picture.where(:id.in=>pic_ids).update_all(category_id: @item.id)    

    @item.update_attributes(_params)   

    redirect_to ace_path_index @item 
  end

  def new
    @item = Category.new
    @item.parent = params[:parent]
  end

  def create
    _params = params[:category]    
    pic_ids = params[:pic_id].split(',').select {|item| item.present?}    
    
    @item = Category.new(_params.to_hash)    

    if @item.save! 

      Picture.where(:id.in=>pic_ids).update_all(category_id: @item.id)        
      redirect_to  ace_path @item
    else
      redirect_to ace_path_index @item
    end
  end  

  def batch_action      
    if params[:type] == "update_all"        
      my_parser (JSON.parse params[:data])
    end

    render json:{result: 1}
  end

  private
  def my_parser(data)  
    data.each do |json|   
      children = json["children"]
      if children 
        children.each do |item|
          child_item = Category.where(id: item["id"]).first
          child_item.parent = json["id"] if child_item
          child_item.save
        end
      end

      my_parser children if children  
    end 
  end
end
