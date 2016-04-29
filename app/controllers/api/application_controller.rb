class Api::ApplicationController < ApplicationController
  protect_from_forgery :except => :upload_avatar

  before_filter :retrieve_current_user
  before_filter :set_page, :only => :index
  before_filter :set_item,  :except => [:index, :create]
  
  layout :false

  include Api::BaseHelper

  private

  def retrieve_current_user
    user_id = session[:user_id]

    @current_user = user_id.nil? ? nil : User.find(user_id)    
    @current_user.client_ip = request.remote_ip if @current_user
    
  end

  def set_page
    @page = params[:page].to_i || 0    
  end

  def set_item
    @item = controller_name.classify.constantize.where(:id => params[:id]).first if params[:id]
  end



end
