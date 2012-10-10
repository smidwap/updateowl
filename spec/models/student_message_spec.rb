require 'spec_helper'

describe StudentMessage do
  describe "#update_message_last_checked_at" do
    it "should update the message's last_checked_at" do
      @student_message = build(:student_message)
      @student_message.send(:update_message_last_checked_at)
      @student_message.message.last_checked_at.should_not == nil
    end
  end
end