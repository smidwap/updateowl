require 'spec_helper'

describe Message do
  before(:each) do
    @message = build_stubbed(:message)
  end

  describe "scopes" do
    describe "weeks_ago" do
      it "should return only messages in the given past week" do
        message_last_week = create(:message)
        message_last_week.update_column(:created_at, 1.week.ago.beginning_of_week)

        message_this_week = create(:message)

        Message.weeks_ago(1).should == [message_last_week]
      end
    end
  end

  describe "#destroy_if_individual_student_is_destroyed" do
    it "should destroy if the individual message no longer has a student" do
      @message.should_receive(:destroy)

      @message.destroy_if_individual_student_is_destroyed
    end

    it "should not destroy if there are still students associated with the message" do
      @message.students = build_stubbed_list(:student, 1)

      @message.should_not_receive(:destroy)

      @message.destroy_if_individual_student_is_destroyed
    end
  end
end
