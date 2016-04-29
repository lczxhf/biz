class Admin::TimedPromotionController < Admin::ApplicationController
  def index
    @columns = ['_id', 'name', 'limit_num_per_user', 'limit_period', 'product', 'updated_at']    
    do_index
  end

  def create
    _params = params[:timed_promotion].to_hash
    
    pids = params[:product_ids].split(',').select {|item| item.present?}
    @item = TimedPromotion.create _params
    Product.where(:id.in => pids).update_all timed_promotion_id:@item.id

    redirect_to ace_path @item
  end

  def show
    @item = TimedPromotion.find params[:id]
  end

  def update
    @item = TimedPromotion.find params[:id]
    _params = params[:timed_promotion].to_hash
    
    @item.update_attributes _params

    pids = params[:product_ids].split(',').select {|item| item.present?}
    Product.where(:id.in => pids).update_all timed_promotion_id:@item.id
    redirect_to ace_path @item
  end

end
