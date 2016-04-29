class Admin::ShippingRuleController < Admin::ApplicationController
  def index
    @columns = ['_id', 'name', 'post_first_fee', 'express_first_fee','updated_at']        
    do_index 
  end

  def update    
    @item = ShippingRule.find(params[:id])

    need_params = params[:shipping_rule].to_hash

    @item.update_attributes(need_params)
    redirect_to ace_path @item
  end

  def create
    need_params = params[:shipping_rule].to_hash

    @item = ShippingRule.create(need_params)    
    
    return redirect_to ace_path @item
  end

  def edit
    @item = ShippingRule.find(params[:id])
  end

  def show
    @item = ShippingRule.find(params[:id])
  end
  
end
