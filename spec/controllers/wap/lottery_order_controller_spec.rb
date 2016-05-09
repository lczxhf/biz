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
			it 'match the list of order_items' do
				get :index
				expect(assigns(:items).map(&:_id)).to eq LotteryOrder.where(user_id:session[:user_id]).map(&:lottery_order_items).flatten.map(&:_id)
			end
		end
	end

	describe '#show' do
		context 'if not log in' do
			it 'will redirect to page of login' do
				get :show,id:create(:user).id
				expect(response).to redirect_to '/wap/session/new'
			end
		end

		context 'if loged in' do
			let!(:activity) {create(:already_end_activity)}
			before {session[:user_id] = User.first.id}
			it 'shwo the order' do
				get :show,id:User.first.lottery_orders.first
				expect(assigns(:order)).to eq User.first.lottery_orders.first

			end
		end
	end

	describe '#create' do
		let!(:activity) {create(:prize_without_order)}
		before do
				@user = create(:user)
				@cart = create(:lottery_cart_item,prize_activity:activity,user:@user)
		end
		context 'if not log in' do
			it 'will redirect to page of login' do
				post :create,params: {lottery_order: [{cart_id: @cart.id, num: @cart.num}].to_json}
				expect(response).to redirect_to '/wap/session/new'
			end
		end

		context 'if loged in' do	
			before do
				session[:user_id] = @user.id
			end
			it 'return success code' do
				post :create,params: {lottery_order: [{cart_id: @cart.id, num: @cart.num}].to_json}
				puts response.body
				expect(JSON.parse(response.body)['result_code']).to eq 1

			end
			it 'add order success' do
				expect {
				post :create,params: {lottery_order: [{cart_id: @cart.id, num: @cart.num}].to_json}
				}.to change(LotteryOrder,:count).by(1)
			end

			it 'addd order_items success' do
				expect {
				post :create,params: {lottery_order: [{cart_id: @cart.id, num: @cart.num}].to_json}
				}.to change(LotteryOrderItem,:count).by(1)
			end 
		end
	end

	describe '#pay' do
		let(:order) {create(:order_without_pay).lottery_order_items.first.lottery_order}
		context 'if not login' do
			it 'will redirect to page of login' do
				get :pay,id:order.id
				expect(response).to redirect_to '/wap/session/new'
			end
		end

		context 'if login ' do
			before do
				session[:user_id] = order.user.id
			end
			context 'if process normally' do
				it 'render the template' do
					get :pay ,id: order.id
					expect(response).to render_template :pay
				end

				it 'lock the lottery' do
					get :pay ,id: order.id
					expect(Lottery.where(used:2).count).to eq 1
				end
			end

			context 'if process exceptionally' do
				before(:each) {request.env["HTTP_REFERER"]= '/wap/session/new'}
				it 'have no available lottery' do
					Lottery.update_all(used:2)
					get :pay ,id: order.id
					expect(response).to have_http_status(302)
				end

				it 'order_item already have lottery' do
					lottery =  Lottery.first.tap {|a| a.update_attribute(:used,2)}
					order.lottery_order_items.first.lotteries << lottery
					get :pay ,id: order.id
					expect(response).to have_http_status(302)
				end
			end
		end
	end
end
