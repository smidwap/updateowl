FactoryGirl.define do
  factory :message do
    user
    body "message body"

    after_build do |message|
      message.students << build(:student)
    end
  end

  factory :undelivered_message, parent: :message do
    after(:build) do |message|
      message.deliveries << build(:undelivered_delivery, message: message)
    end
  end

  factory :delivered_message, parent: :message do
    after(:build) do |message|
      message.deliveries << build(:delivered_delivery, message: message)
    end
  end
end