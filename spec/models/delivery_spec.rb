require 'spec_helper'

describe Delivery do
  before(:each) do
    @delivery = build_stubbed(:delivery)
  end

  describe "#deliver" do
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
