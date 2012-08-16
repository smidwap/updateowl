require 'spec_helper'

describe Delivery do
  before(:each) do
    @delivery = build_stubbed(:delivery)
  end

  describe "#deliver_via_email" do
    it "should send an email to the student's parent" do
      @delivery = build(:delivery)
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

      @delivery.delivered_at.should_not == nil
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
      first_unsuccessful_delivery = create(:undelivered_delivery)
      successful_delivery = create(:delivered_delivery, parent: first_unsuccessful_delivery.parent)
      next_unsuccessful_delivery = create(:undelivered_delivery, parent: first_unsuccessful_delivery.parent)

      first_unsuccessful_delivery.next_delivery.should == next_unsuccessful_delivery
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
