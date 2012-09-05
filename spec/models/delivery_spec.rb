require 'spec_helper'

describe Delivery do
  before(:each) do
    @delivery = build_stubbed(:delivery)
  end

  describe "#deliver_via_email" do
    it "should send an email to the student's parent" do
      @delivery = create(:delivery)
      @delivery.parent = build_stubbed(:parent_prefers_email)

      @delivery.deliver_via_email

      email = ActionMailer::Base.deliveries.last
      email.should_not == nil
      email['to'].to_s.should == @delivery.parent.email
    end
  end

  describe "#checked!" do
    it "should mark the delivery has having been checkedly delivered" do
      @delivery.checked!

      @delivery.delivered_at.should_not == nil
    end

    it "should not change the delivered_at timestamp if the delivery is already checked" do
      time = 3.weeks.ago
      @delivery.delivered_at = time

      @delivery.checked!

      @delivery.delivered_at.should == time
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
      @delivery.message = build_stubbed(:message, spanish_body: 'hola')
    end

    it "should return the english version of the message if the parent does not require translation" do
      @delivery.message_body.should == @delivery.message.body
    end

    it "should return the spanish version of the message if the parent speaks spanish" do
      @delivery.parent = build_stubbed(:spanish_parent)

      @delivery.message_body.should == @delivery.message.spanish_body
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
