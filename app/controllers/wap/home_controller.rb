class Wap::HomeController < Wap::ApplicationController
  layout 'wap_home'

  def index
    @index_banners = IndexBanner.all

    @categories = Category.where(level:1)
  end
  
end
