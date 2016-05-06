FactoryGirl.define do 
	factory :prize_activity do
		name 'Test'
		begin_time Time.now
		association :prize
		factory :manual_generate_lotteries do
				after(:create) do |activity|
					activity.total_share.times.each do 
						activity.lotteries << create(:lottery,prize_activity:activity)
					end
				end
		end

		factory :already_end_activity do
				after(:create) do |activity|
					activity.total_share.times.each do |index|
						order = create(:pay_order,real_amount:activity.prize.sale_unit)
						item = create(:pay_order_item,num:activity.prize.sale_unit,prize:activity.prize,prize_activity:activity,lottery_order:order)
						activity.lotteries << lottery = create(:already_saled_lottery,prize_activity:activity,lottery_order_item:item,seq:10000001+index,user:order.user)
					end
					activity.check_if_done
				end
		end
	end
end