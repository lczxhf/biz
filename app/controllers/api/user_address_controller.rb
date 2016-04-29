class Api::UserAddressController < Api::CheckLoginController
   
  def create
    address = UserAddress.new params[:user_address].to_hash
    address.user = @current_user
    address.save
    render json:{result_code: 1 , url: '/wap/user_address'}
  end

  def update
    address = UserAddress.find params[:id]

    if params[:user_address][:is_default]
      @current_user.user_addresses.update_all   is_default:false
    end

    address.update_attributes params[:user_address].to_hash

    render json:{result_code: 1, url: '/wap/user_address'}
  end

  def destroy
    @item.destroy if @item
    render json:{result_code: 1}
  end

end
