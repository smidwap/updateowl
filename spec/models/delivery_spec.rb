require 'spec_helper'

describe Delivery do
  before(:each) do
    @delivery = build(:delivery)
  end

  describe "#deliver_via_email" do
    before(:each) do
      @delivery = create(:delivery)
      @delivery.parent = build_stubbed(:parent_prefers_email)
    end

    it "should send an email to the student's parent" do
      @delivery.deliver_via_email

      email = ActionMailer::Base.deliveries.last
      email.should_not == nil
      email['to'].to_s.should == @delivery.parent.email
    end
  end

  describe "#checked!" do
    it "should mark the delivery as having been checked" do
      @delivery.checked!

      @delivery.checked_at.should_not == nil
    end

    it "should not change the checked_at timestamp if the delivery is already checked" do
      time = 3.weeks.ago
      @delivery.checked_at = time

      @delivery.checked!

      @delivery.checked_at.should == time
    end
  end

  describe "#next_delivery?" do
    it "should return true when the parent has an undelivered delivery after this one" do
      @delivery.stub(:next_delivery).and_return build_stubbed(:undelivered_delivery)

      @delivery.next_delivery?.should == true
    end

    it "should return false if the parent does not have an undelivered delivery after this one" do
      @delivery.stub(:next_delivery).and_return nil

      @delivery.next_delivery?.should == false
    end
  end

  describe "#next_delivery" do
    it "should return the parent's next undelivered delivery" do
      first_unchecked_delivery = create(:undelivered_delivery)
      checked_delivery = create(:delivered_delivery, parent: first_unchecked_delivery.parent)
      next_unchecked_delivery = create(:undelivered_delivery, parent: first_unchecked_delivery.parent)

      first_unchecked_delivery.next_delivery.should == next_unchecked_delivery
    end
  end

  describe "message_body" do
    before(:each) do
      @message = build_stubbed(:message, spanish_body: 'hola')
      @delivery.stub(:message).and_return @message
    end

    it "should return the english version of the message if the parent does not require translation" do
      @delivery.message_body.should == @message.body
    end

    it "should return the spanish version of the message if the parent speaks spanish" do
      @delivery.parent = build_stubbed(:spanish_parent)

      @delivery.message_body.should == @message.spanish_body
    end
  end

  describe "#update_student_message_as_checked" do
    it "should set the student message as checked" do
      @delivery.send(:update_student_message_as_checked)
      @delivery.student_message.checked_at.should_not == nil
    end
  end

  describe "#should_deliver_immediately?" do
    it "should return true if the parent's communication prefernece is email" do
      @delivery.parent = build_stubbed(:parent_prefers_email)

      @delivery.send(:should_deliver_immediately?).should == true
    end

    it "should return false if the parent's communication preference is phone" do
      @delivery.parent = build_stubbed(:parent_prefers_phone)

      @delivery.send(:should_deliver_immediately?).should == false
    end
  end
end
