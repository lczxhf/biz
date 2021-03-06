class Admin::ApplicationController < ApplicationController
  include Admin::ApplicationHelper
  
  layout 'admin'

  before_action :check_current_user, :set_page, :set_breadcrumb

  # authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/422.html', :alert => exception.message
  end

  def check_current_user
    @admin_user = AdminUser.find_by_id session[:admin] if session[:admin]
    # G.t @current_admin

    if @admin_user.nil?    
      respond_to do |format|
        format.json {render json: { result_code: Settings.verify_login, error_message: Settings.info_600}.to_json and return}
        format.html {redirect_to  new_admin_user_session_path and return}
      end
    end
    
  end 

  def set_page
    @page = params[:page].to_i || 0    
    gon.base_url = "/admin/#{controller_name}/"     
  end

  def set_breadcrumb
    @breadcrumb = []
    @breadcrumb << {"/admin/#{controller_name}" => I18n.t("models.#{controller_name}", default: controller_name)}
    @opts = {hide_new: false, hide_delete: false, hide_edit: false}
  end

  def do_index(items =nil)    
    model_name = controller_name.classify.constantize

    params[:start] ||= 0
    params[:length] ||= 10
    params[:draw] ||= 1    

    @draw = params[:draw].to_i

    @items = items

    @items ||= model_name.skip(params[:start])

    columns = params[:columns]

    @len = params[:length].to_i
    @len = 0 if @len == -1
    @items = @items.limit(@len)
    if params[:search]
      value = params[:search][:value]
      @items = @items.full_text_search value  if value != ""
    end

    if params[:order]      
      column = params[:order]["0"]["column"]
      col = columns[column]
      dir = params[:order]["0"]["dir"]
      @items = @items.send(dir, col["data"])
    else
      @items = @items.desc(:updated_at)
    end
    
    respond_to do |format|
      unless block_given?        
        format.html { render "/common/index" }
      else
        format.html {yield}
      end
      format.json  { render "index.json", layout: nil}
    end    
  end

  def new
    @item = controller_name.classify.constantize.new
    render "new"
  end

  
  def show    
    @item = controller_name.classify.constantize.find(params[:id])
    render "/common/show", locals:{item:@item}
  end

  def edit
    @item = controller_name.classify.constantize.find params[:id]
    render 'edit'
  end

  def update
    @item = controller_name.classify.constantize.find params[:id]

    @item.update_attributes params[:controller_name].to_hash

    redirect_to "/admin/#{controller_name}/@item.id"
  end


  def destroy
    item =  controller_name.classify.constantize.find(params[:id])
    if item.respond_to? :state
      item.state = 100      
      item.save
    else
      item.destroy  
    end   

    render json:{result_code: 1}
  end

  def batch_delete
    params[:ids].each do |id|
      item =  controller_name.classify.constantize.find id
      if item.respond_to? :soft_delete!
        item.soft_delete!
      else
        item.destroy  
      end      
    end
    render json:{result_code: 1}
  end

end
