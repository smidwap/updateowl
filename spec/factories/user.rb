FactoryGirl.define do
  factory :user do
    email
    school
    password "password"
  end
  
  sequence :email do |n|
    "matt+#{n}@developertown.com"
  end
end