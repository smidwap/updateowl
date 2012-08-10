FactoryGirl.define do
  factory :message do
    user
    student
    body "message body"
  end

  factory :undelivered_message, parent: :message do
    after(:build) do |message|
      message.deliveries << build(:undelivered_delivery, message: message)
    end
  end

  factory :delivered_message, parent: :message do
    after(:build) do |message|
      # message.deliveries << build(:delivered_delivery, message: message)
      message.deliveries << build(:delivered_delivery, message: message)
    end
  end
end