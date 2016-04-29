require 'rails_helper'

RSpec.describe Wap::LotteryOrderController, type: :controller do
	before(:each) do 
		post "/api/sign_in",mobile:'15817378124',password:'123123123'
	end
	describe 'get #pay' do
		it 'test' do
			get 'index'
			count = User.count
			expect(count).to eq(1)
	end
	end

end
