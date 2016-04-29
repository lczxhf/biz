class Admin::DashBoardController < Admin::ApplicationController
  def index

    @cats = Category.where(level: 0)
    @items = User.all

    @products = Product.all
    @orders = Order.all
  end
end
