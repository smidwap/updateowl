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
      it "should return only messages that have one or more successful deliveries" do
        successful_delivery = create(:delivery, success: true)
        unsuccessful_delivery = create(:delivery, success: false)

        Message.checked.should == [successful_delivery.message]
      end
    end

    describe "unchecked" do
      it "should return only messages that have no successful deliveries" do
        message_without_delivery = create(:message)
        message_with_unsuccessful_delivery = create(:delivery, success: false).message
        message_with_successful_delivery = create(:delivery, success: true).message

        Message.unchecked.should include message_without_delivery, message_with_unsuccessful_delivery
      end
    end
  end

  describe "#queue_delivery_setup" do
    it "should queue the DeliverySetup worker" do
      Resque.should_receive(:enqueue).with(DeliverySetup, @message.id)

      @message.send(:queue_delivery_setup)
    end
  end
end
