class Admin::ProductController < Admin::ApplicationController
  include Admin::ApplicationHelper

  def index    
    @columns = ['_id','name','category', 'state', 'u_at']
    do_index
  end

  def new
    @item = Product.new
    @data = {}
    @data[:items] = Category.where(level: 0)
    @data[:level] = 0
    @data[:default] = Category.default

  end

  def show
    @item = Product.find(params[:id])
    
    @cats = Category.where(level: 0)
    @data = {}
    @data[:items] = @cats
    @data[:level] = 0
    @data[:default] = @item.category.ancestors if @item.category
    @data[:default] ||= Category.default

    @action_url = ace_path @item    
  end

  def create
    _params = params[:product].to_hash   

    model = Product.new(_params)

    if model.save! 
      redirect_to  ace_path model, :edit
    else
      redirect_to ace_path model
    end
  end

  def edit
    @item = Product.find(params[:id])
    @cats = Category.where(level: 0)
    @data = {}
    @data[:items] = @cats
    @data[:level] = 0
    @data[:default] = @item.category.ancestors if @item.category
    @data[:default] ||= Category.default
    
    @action_url = ace_path @item    

  end

  def update
    product = Product.find(params[:id])

    if  params[:product]
      params[:product][:is_hot] ||= false
      product.update_attributes(params[:product].to_hash)
    end

    if params[:product_property_types]
      params[:product_property_types].to_hash.each do |id, v|
        property = product.product_property_types.find(id)
        property.value = v 
        property.save
      end
    end

    if params[:variant]
      params[:variant].to_hash.each do |id, v|
        Variant.find(id).update_attributes v.to_hash
      end
    end

    # product.content = params[:content] if params[:content]
    # product.save

    redirect_to ace_path product
  end

end
