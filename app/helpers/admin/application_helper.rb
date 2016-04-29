module Admin::ApplicationHelper
  
  def ace_path (item, action=nil)
    return "/admin/#{item.class.name.underscore}/#{item.id}" if action.nil?
    "/admin/#{item.class.name.underscore}/#{item.id}/#{action}"
  end

  def ace_path_create item
    "/admin/#{item.class.name.underscore}"    
  end  

  def ace_path_index item
    "/admin/#{item.class.name.underscore}"    
  end  

  def ace_path_new
    "/admin/#{controller_name}/new"    
  end  

  def ace_path_edit item
    ace_path item, :edit
  end  

  def is_manager?
    # @admin_user.role == 1
    false
  end

  def is_admin?
    # @admin_user.role == 0
    false
  end
end
