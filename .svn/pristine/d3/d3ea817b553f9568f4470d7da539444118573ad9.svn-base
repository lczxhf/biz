class Admin::ValidateCodeController < Admin::ApplicationController

  def index

    @columns = ['_id','dest', 'code', 'template', 'is_verify', 'updated_at']    
    @opts[:hide_new] = true

    do_index
  end

end
