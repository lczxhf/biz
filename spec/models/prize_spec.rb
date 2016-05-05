require 'rails_helper'

describe Prize, type: :model do 
  let(:prize) { build(:prize,price:100,sale_unit:20)}
  it "#total_share" do 
  	  expect(prize.total_share).to eq 5
  end 
end