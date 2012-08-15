FactoryGirl.define do
  factory :delivery do
    parent
    message
    access_code 'fefwefwef'
  end

  factory :delivered_delivery, parent: :delivery do
    delivered_at Time.now
  end

  factory :undelivered_delivery, parent: :delivery do
  end
end