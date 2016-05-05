FactoryGirl.define do 
	factory :lottery do
		sequence(:seq) {|n| n+10000001}
		association :prize_activity
		used 0

		factory :already_saled_lottery do
			used 1
			association :user
		end
	end
end