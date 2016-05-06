FactoryGirl.define do
  factory :lottery_cart_item do
    num 10
    association :user
    association :prize_activity
  end
end
