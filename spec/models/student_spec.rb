require 'spec_helper'

describe Student do
  before(:each) do
    @student = build_stubbed(:student)
  end

  describe "scopes" do
    describe "parent scopes" do
      before(:each) do
        @student_with_parent = create(:student)
        @student_with_parent.parents << create(:parent)

        @student_without_parent = create(:student)
      end

      describe "with_registered_parents" do
        it "should only return students that have registered parents" do
          Student.with_registered_parents.should == [@student_with_parent]
        end
      end

      describe "without_registered_parents" do
        it "should only return students without registered parents" do
          Student.without_registered_parents.should == [@student_without_parent]
        end
      end
    end
  end

  describe "#create_pin" do
    it "should save the student's pin as a transformation of the student's id into a 5 digit integer" do
      @student.id = 10

      @student.send(:create_pin)

      @student.pin.should == '00120' # id * 11 + id
    end
  end
end
