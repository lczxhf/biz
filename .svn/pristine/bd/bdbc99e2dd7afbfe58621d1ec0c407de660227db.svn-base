class Admin::VariantController < Admin::ApplicationController

  def new
    @item = Variant.new    
    @item.product = Product.find params[:product_id]
  end

  def create
    @item = Variant.new params[:variant].to_hash

    @item.option_value_ids << params[:option_value_ids]
    @item.option_value_ids.flatten!

    respond_to do |format|
      if @item.save    
        format.html { redirect_to admin_variant_path, notice: '新增成功。' }    
        format.js
      else
        format.html { render :new }
        format.js
      end

    end
  end

  # def destroy
  #   @item = Variant.find params[:id]        
  #   @item.delete
  # end
  
end
