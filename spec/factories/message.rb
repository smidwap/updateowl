FactoryGirl.define do
  factory :message do
    user
    student
    body "message body"
  end
end