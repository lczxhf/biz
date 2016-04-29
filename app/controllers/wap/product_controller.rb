class Wap::ProductController < Wap::ApplicationController
  layout 'wap_product_index'

  def index
    gon.params = params.to_hash
    flash.now[:referer] = '/wap/home'
  end

  def show
    @item = Product.find params[:id]

    @item.write_attribute :view_count, @item.view_count + 1

    @title = '商品详情'

    vc = VisitProductRecord.find_or_create_by user:@current_user, product: @item

    render 'show',layout: "wap_no_bottom"
  end
end
