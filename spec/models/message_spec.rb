require 'spec_helper'

describe Message do
  before(:each) do
    @message = build_stubbed(:user)
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
end
