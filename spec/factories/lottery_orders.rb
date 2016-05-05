FactoryGirl.define do 
	factory :lottery_order do
		pay_time Time.now
		pay_state 0
		association :user
		
	end
end