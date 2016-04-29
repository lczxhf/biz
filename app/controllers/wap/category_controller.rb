class Wap::CategoryController < Wap::ApplicationController
  def index
    @title = '分类'
    @categories = []
    Category.where(level:1).each do |cat|
      @categories << cat.get_tree
    end
    
  end
end
