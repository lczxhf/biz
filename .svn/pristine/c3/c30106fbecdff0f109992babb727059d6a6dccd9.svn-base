class Admin::ShopController < Admin::ApplicationController
  include Admin::ApplicationHelper
  
  def index
    @columns = ['_id','name', 'contactor', 'address', 'state', 'updated_at']
    
    do_index
  end

  def show
    @item = Shop.find(params[:id])    
  end

  def edit
    @item = Shop.find(params[:id])
    @action_url = ace_path @item

    params[:r] ||= 'basic'
    page = "edit_#{params[:r]}"

    return render page
  end

  def update
    @item = Shop.find(params[:id])

    if params[:shop]
      need_params = params[:shop].to_hash
      @item.update_attributes need_params
    end

    @item.loc[0] = params[:lng].to_f if params[:lng]
    @item.loc[1] = params[:lat].to_f if params[:lat]

    if @item.save
      return redirect_to ace_path @item #, :notice => '更新成功'
    end

    redirect_to redirect_to ace_path @item #, :notice => '更新失败'

  end


  def create
    _params = params[:shop].to_hash
    @item = Shop.new(_params)    

    if @item.save
      return redirect_to ace_path @item, :edit #, :notice => '更新成功'
    end

    redirect_to redirect_to ace_path @item #, :notice => '更新失败'
  end

end
