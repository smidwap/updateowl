require 'spec_helper'

describe User do
  before(:each) do
    @user = build_stubbed(:user)
  end

  describe "#has_student?" do
    before(:each) do
      @student = build(:student)
    end

    it "should return true if the user has a relationship with the passed student" do
      @user.students << @student

      @user.has_student?(@student).should == true
    end

    it "should return false if the user doesn't have a relationship with the passed student" do
      @user.has_student?(@student).should == false
    end
  end
end
