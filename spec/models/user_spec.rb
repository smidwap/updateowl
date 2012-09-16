require 'spec_helper'

describe User do
  before(:each) do
    @user = build(:user)
  end

  describe "scopes" do
    describe "messages.last_week" do
      it "should return only messages sent last week from this user" do
        message_last_week = create(:message, user: @user)
        message_last_week.update_attribute(:created_at, 1.week.ago.beginning_of_week)
        message_this_week = create(:message, user: @user)

        @user.messages.last_week.should == [message_last_week]
      end
    end
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
