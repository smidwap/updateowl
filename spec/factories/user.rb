FactoryGirl.define do
  factory :user do
    email
    password "password"
  end
  
  sequence :email do |n|
    "matt+#{n}@developertown.com"
  end
end