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

    describe "checked" do
      it "should return only messages that have one or more checked deliveries" do
        checked_delivery = create(:delivered_delivery)
        unchecked_delivery = create(:undelivered_delivery)

        Message.checked.should == [checked_delivery.message]
      end
    end

    describe "unchecked" do
      it "should return only messages that have no checked deliveries" do
        message_without_delivery = create(:message)
        message_with_unchecked_delivery = create(:undelivered_delivery).message
        message_with_checked_delivery = create(:delivered_delivery).message

        Message.unchecked.should include message_without_delivery, message_with_unchecked_delivery
      end
    end
  end

  describe "checked?" do
    it "should return true if one or more deliveries of this message is successul" do
      message = create(:delivered_message)

      message.checked?.should == true
    end

    it "should return false if none of the deliveries is checked" do
      message = create(:undelivered_message)

      message.checked?.should == false
    end
  end

  describe "#queue_delivery_setup" do
    it "should queue the DeliverySetup worker" do
      Resque.should_receive(:enqueue).with(DeliverySetup, @message.id)

      @message.send(:queue_delivery_setup)
    end
  end
end
