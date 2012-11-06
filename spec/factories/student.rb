FactoryGirl.define do
  factory :student do
    grade_level
  end

  factory :student_with_parent, parent: :student do
    after_build(:build) do |student|
      student.parents << create(:parent)
    end
  end

  factory :student_with_spanish_speaking_parent, parent: :student do
    after_build(:build) do |student|
      student.parents << create(:spanish_parent)
    end
  end
end