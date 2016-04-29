class Admin::UserController < Admin::ApplicationController
  include Admin::ApplicationHelper

  def index
    @columns = ['_id','name', 'mob', 'score', 'updated_at', "join_at"]    
    do_index
  end

  def show
    @item = User.find(params[:id])
    render "show"
  end

  def new
    @item = User.new
  end

  def edit
    @item = User.find(params[:id])
  end

  def update
    @item = User.find(params[:id])
    @item.update_attributes params[:user].to_hash

    render "show"
  end

end
