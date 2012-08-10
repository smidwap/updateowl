require 'spec_helper'

describe Delivery do
  before(:each) do
    @delivery = build_stubbed(:delivery)
  end

  describe "#deliver_via_email" do
    it "should send an email to the student's parent" do
      @delivery.parent = build_stubbed(:parent_prefers_email)

      @delivery.deliver_via_email

      email = ActionMailer::Base.deliveries.last
      email.should_not == nil
      email['to'].to_s.should == @delivery.parent.email
    end
  end

  describe "#checked" do
    it "should mark the delivery has having been successfully delivered" do
      @delivery.checked!

      @delivery.success.should == true
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
