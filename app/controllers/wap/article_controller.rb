class Wap::ArticleController < Wap::ApplicationController
  layout 'wap_no_bottom'
  
  def index
    @title = '活动'
  end

  def show
    @item = Article.find params[:id]
    @title = @item.name
  end
end
