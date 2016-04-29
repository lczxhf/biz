require 'rails_helper'
require 'factory_girl'
require  'prize'

describe Prize, '#total_share' do 

  it 'total_share' do
    prize = Prize.new name:"one", price:1000, sale_unit:100
    p prize.total_share

    expect(prize.total_share).to eq 10
  end
  
end