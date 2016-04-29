require 'rails_helper'

require  'lottery'

RSpec.describe Lottery, '.ip2address' do

  it 'ip2address' do

    lottery = Lottery.create user_ip:'117.136.40.177'
    lottery.delay.ip2address
    expect(lottery.address).to eq '广东省广州市'
  end


end
