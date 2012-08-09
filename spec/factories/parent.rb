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
end