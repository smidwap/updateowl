require 'spec_helper'

describe Message::Checkable do
  before(:each) do
    @message = build_stubbed(:message)
  end

  describe "#percentage_checked_octile" do
    before(:each) do
      @message.student_messages_count = 16
    end

    it "should return 0 if the percentage check is 0" do
      @message.checks_count = 0

      @message.percentage_checked_octile.should == 0
    end

    it "should return 1 if the percentage checked is greater than 0 and less than or equal to 12.5%" do
      @message.checks_count = 1

      @message.percentage_checked_octile.should == 1
    end

    it "should return 2 if the percentage checked is greater than 12.5% and less than or equal to 25%" do
      @message.checks_count = 4

      @message.percentage_checked_octile.should == 2
    end
  end

  describe "#percentage_checked" do
    it "should returned the percentage of students whose parents have checked this message" do
      @message.student_messages_count = 10
      @message.checks_count = 3

      @message.percentage_checked.round(2).should == 0.30
    end
  end
end