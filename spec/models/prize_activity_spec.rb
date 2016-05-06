require 'rails_helper'

describe PrizeActivity, type: :model do 
	
  	describe 'after create' do
  		let(:prize_activity) {create(:prize_activity)}
  		it '#init_lotteries' do
  			prize_activity

  			expect(Delayed::Job.where(handler:/init_lotteries_without_delay/).count).to eq 1
  		end
  	end

  	describe 'after generate lotteries manually' do
  		let(:prize_activity) {create(:manual_generate_lotteries)}
  		it "#is_done?" do
  			expect(prize_activity.is_done?).to eq(false)
  		end

  		it "#total_share" do
  			expect(prize_activity.total_share).to eq 10
  		end

  		it '#saled_share' do
  			a = rand(1..10)
  			prize_activity.lotteries.take(a).each {|a| a.update_attribute(:used,1)}
  			expect(prize_activity.saled_share).to eq a
  		end

  		it '#remain_share' do
  			prize_activity.lotteries.take(3).each {|a| a.update_attribute(:used,1)}
  			expect(prize_activity.remain_share).to eq 7
  		end

  		describe '#prev_activity' do
  			it 'is first time' do
  				expect(prize_activity.prev_activity).to eq nil
  			end

  			it 'is not first time' do
  				second = create(:manual_generate_lotteries,prize:prize_activity.prize,begin_time:prize_activity.begin_time+10.seconds)
  				expect(second.prev_activity).to eq(prize_activity)
  			end

  			it 'is not same prize' do
  				second = create(:manual_generate_lotteries,begin_time:prize_activity.begin_time+10.seconds)
  				expect(second.prev_activity).to eq nil
  			end
  		end
  	end

  	describe 'after end the prize_activity' do
  		let(:prize_activity) {create(:already_end_activity)}
  		describe 'check_if_done' do
  			
  			it 'have lucky_no' do
  				expect(prize_activity.lucky_no).to match be_between(10000001, 10000010).inclusive
  			end
  			it 'have end_time' do 
  				expect(prize_activity.end_time).not_to eq nil
  			end

  			it 'lottery is_win have value' do

  				expect(prize_activity.lotteries.where(is_winner:true).count).to eq 1
  				expect(prize_activity.lotteries.where(is_winner:true).first.seq).to eq prize_activity.lucky_no
  			end
  		end
  		context '#time_of_user_buy' do
  			it 'pass user' do
  				 prize_activity

  				 expect(prize_activity.time_of_user_buy(User.first)).to eq 1
  			end
  			it 'not pass user' do
  				prize_activity
  				expect(prize_activity.time_of_user_buy).to eq 1
  			end
  		end

  		context '#get_all_order' do
  			it 'pass num' do
  				expect(prize_activity.get_all_order(1,5).to_a.size).to eq 5
  			end

  			it 'not pass num' do
  				prize_activity
  				arr = User.all.map{|a| a.lottery_orders.map{|b| b.id}}.flatten
  				expect(prize_activity.get_all_order.map {|a| a.lottery_order.id}).to match_array arr
  			end
  		end
  	end
end