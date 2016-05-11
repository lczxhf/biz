class Admin::OptionTypeController <  Admin::ApplicationController
  include Admin::ApplicationHelper

  def index    
    @columns = ['_id','name', 'option_values', 'u_at']
    do_index
  end

  def new
    @item = OptionType.new    
  end

  def create
    need_params =  params[:option_type].to_hash

    @item = OptionType.create :name => need_params["name"]

    opts = need_params["option_values"].gsub('，', ",").split(',')

    opts.each do |opt|
      option = OptionValue.find_or_create_by(name:opt)
      option.option_type =  @item      
      option.save!
    end

    redirect_to ace_path_index @item
  end

  def edit
    @item = OptionType.find_by_id params[:id]
  end

  def show 
    @item = OptionType.find_by_id params[:id]
  end

  def update
    @item = OptionType.find_by_id params[:id]
    need_params =  params[:option_type].to_hash
    @item.update_attributes need_params

    redirect_to ace_path @item
  end

end
