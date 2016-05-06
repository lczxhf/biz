FactoryGirl.define do 
	factory :lottery_order do
		
		pay_state 0
		association :user
		province '广东'
		city {Faker::Address.city}
		dist '罗湖'
		street {Faker::Address.street_name }
		zipcode {Faker::Address.postcode}
		trade_no {Faker::Number.number(10)}

		factory :pay_order do
			pay_time Time.now
			pay_state 1
		end
	end
end