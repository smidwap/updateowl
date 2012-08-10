FactoryGirl.define do
  factory :delivery do
    parent
    message
    access_code 'fefwefwef'
  end

  factory :delivered_delivery, parent: :delivery do
    success true
  end

  factory :undelivered_delivery, parent: :delivery do
    success false
  end
end