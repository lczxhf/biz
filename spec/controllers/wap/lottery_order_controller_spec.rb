require 'rails_helper'

RSpec.describe Wap::LotteryOrderController, type: :controller do
	describe '#index' do
	  	context 'if not log in' do
			it 'will redirect to page of login' do
				get :index
				expect(response).to redirect_to '/wap/session/new'
			end

			it 'also add a temp user' do
				get :index
				expect(User.count).to eq 1
			end
		end

		context 'if loged in' do
			let!(:activity) {create(:already_end_activity)}
			before {session[:user_id] = User.first.id}
			it 'loged in' do
				get :index
				puts assigns(:items)
				expect(assigns(:items).map(&:_id)).to eq LotteryOrder.where(user_id:session[:user_id]).map(&:lottery_order_items).flatten.map(&:_id)
			end
		end
	end

end
