FactoryGirl.define do
  factory :student do
    grade_level
  end

  factory :student_with_parent, parent: :student do
    after_build(:build) do |student|
      student.parents << create(:parent)
    end
  end
end