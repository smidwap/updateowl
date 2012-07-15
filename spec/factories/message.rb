FactoryGirl.define do
  factory :message do
    sender factory: :user
    student
  end
end