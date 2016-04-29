class Admin::NoticeController < Admin::ApplicationController
        
  def index    
    @columns = ['_id','event_type', 'event_count', 'updated_at']    
    @opts[:hide_new] = true

    do_index Notice.where(:admin_user => @admin_user).desc(:u_at)
  end

  def show
    @item = Notice.find(params[:id])
    @item.update_attribute :read, true

    redirect_to "/admin/#{@item.show_controller}"
  end
end
