FactoryGirl.define do
  factory :lottery_order_item do
    	num 10
    	pay_state 0

    	factory :pay_order_item do 
    		pay_state 1
    	end
  end
end
