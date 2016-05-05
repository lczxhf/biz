
FactoryGirl.define do
  factory :user do |f|
    f.name {Faker::Name.name}
    f.mob  {Faker::PhoneNumber.phone_number}
    f.password_salt '123456'
    f.password_digest '123456'
  end
end