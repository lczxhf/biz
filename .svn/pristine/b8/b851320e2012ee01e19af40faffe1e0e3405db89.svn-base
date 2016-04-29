require 'rails_helper'
require 'factory_girl'
require  'prize'
require  'prize_activity'
require  'lottery'

describe PrizeActivity, '#total_share' do 

  it 'auto lottery create' do
    prize = Prize.create name:"one", price:1000, sale_unit:100
    prize_activity = PrizeActivity.create prize:prize
    

    expect(Lottery.count).to eq 10
  end
  
end