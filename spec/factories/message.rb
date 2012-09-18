FactoryGirl.define do
  factory :message do
    user
    body "message body"

    after_build do |message|
      message.students << build(:student)
    end
  end

  factory :individual_message, parent: :message do
  end

  factory :mass_message, parent: :message do
    after_build do |message|
      message.students << build_list(:student, 2)
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

  factory :delivered_individual_message, parent: :individual_message do
    after(:build) do |message|
      message.deliveries << build(:delivered_delivery, message: message)
    end
  end

  factory :delivered_mass_message, parent: :mass_message do
    after(:build) do |message|
      message.deliveries << build(:delivered_delivery, message: message)
    end
  end
end