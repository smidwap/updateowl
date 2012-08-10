FactoryGirl.define do
  factory :parent do
    preference "email"
    email "matt@developertown.com"
  end

  factory :parent_prefers_email, parent: :parent do
    email "matt@developertown.com"
    preference "email"
  end

  factory :parent_prefers_phone, parent: :parent do
    phone "+12193090213"
    preference "phone"
  end

  factory :parent_with_unchecked_message, parent: :parent do
    after(:create) do |parent|
      parent.deliveries << build(:undelivered_delivery, parent: parent)
    end
  end

  factory :parent_with_checked_message, parent: :parent do
    after(:create) do |parent|
      parent.deliveries << build(:delivered_delivery, parent: parent)
    end
  end
end