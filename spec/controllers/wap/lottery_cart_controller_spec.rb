require 'rails_helper'

RSpec.describe Wap::LotteryCartController, type: :controller do
	describe '#index' do
		it "returns http success" do
      		get :index
      		expect(response).to have_http_status(:success)
    	end
	end

	describe '#create' do
		it 'have not pass param' do
			post :create
			expect(JSON.parse(response.body)['result_code']).to eq -1
		end

		context 'have pass param' do
			let(:activity) {create(:prize_activity)}
			before { session[:user_id] = create(:user).id }

			it 'will returns 200' do
				post :create, prize_activity_id: activity.id
				expect(response).to have_http_status(:success)
			end
	
			it 'will create a new cart' do
				post :create, prize_activity_id: activity.id
				expect(activity.reload.lottery_cart_items.count).to eq 1
			end

			it 'will update sum from old cart' do
				activity.lottery_cart_items.create(user_id:session[:user_id],num: activity.prize.sale_unit)
				post :create,prize_activity_id: activity.id
				expect(activity.reload.lottery_cart_items.count).to eq 1
				expect(activity.reload.lottery_cart_items.first.num).to eq activity.prize.sale_unit*2
			end
		end
	end

	describe '#destroy' do
		let(:lottery_cart_item) {create(:lottery_cart_item)}
		before { session[:user_id] = lottery_cart_item.user.id}

		it 'returns json include result_code' do
			process :destroy,method: :post,params: { id: lottery_cart_item.id }
			expect(JSON.parse(response.body)['result_code']).to eq 1
		end
	end

end
