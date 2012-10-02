require 'spec_helper'

describe User do
  before(:each) do
    @user = build(:user)
  end

  describe "scopes" do
    describe "has_sent_a_message_since" do
      it "should return users who have sent at least one message since the given time"
    end
  end

  describe "#weekly_message_counts" do
    it "should return counts for the given number of past weeks" do
      num_messages_this_week = 1
      num_messages_last_week = 2

      create_list(:message, num_messages_this_week, user: @user)
      create_list(:message, num_messages_last_week, user: @user).each do |message|
        message.update_column(:created_at, 1.week.ago)
      end

      @user.weekly_message_counts(6).should == [num_messages_this_week, num_messages_last_week, 0, 0, 0, 0]
    end
  end
end
