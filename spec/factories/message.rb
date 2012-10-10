FactoryGirl.define do
  factory :message do
    user
    body "message body"
  end

  factory :individual_message, parent: :message do
  end

  factory :mass_message, parent: :message do
    after(:build) do |message|
      message.students << build_list(:student, 2)
    end
  end

  factory :delivered_individual_message, parent: :individual_message do
    after(:build) do |message|
      message.checks_count = 1
    end
  end

  factory :delivered_mass_message, parent: :mass_message do
    after(:build) do |message|
      message.checks_count = 1
    end
  end
end