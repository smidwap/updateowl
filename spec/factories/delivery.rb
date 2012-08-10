FactoryGirl.define do
  factory :delivery do
    parent
    message
    access_code 'fefwefwef'
  end

  factory :successful_delivery, parent: :delivery do
    success true
  end

  factory :unsuccessful_delivery, parent: :delivery do
    success false
  end
end