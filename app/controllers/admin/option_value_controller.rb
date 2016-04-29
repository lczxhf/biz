class Admin::OptionValueController < Admin::ApplicationController
  def new
    @item = OptionValue.new    
  end

  def create
    @item = OptionValue.new params[:option_value].to_hash
    respond_to do |format|
      if @item.save    
        format.html { redirect_to admin_option_value_path, notice: '新增成功。' }    
        format.js
      else
        format.html { render :new }
        format.js
      end

    end
  end

end
