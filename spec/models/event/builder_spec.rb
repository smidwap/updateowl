require 'spec_helper'

describe Event::Builder do
  describe "#events" do
    it "should sort new messages and checked message events by most recent first" do
      @user = build_stubbed(:user)
      builder = Event::Builder.new(@user)

      new_message = Event::NewMessage.new(build_stubbed(:message))
      new_message.time = 3.days.ago

      checked_message = Event::CheckedMessage.new(build_stubbed(:delivered_delivery))
      checked_message.time = Time.now

      builder.stub(:unordered).and_return [new_message, checked_message]

      events = builder.events

      events[0].should be_instance_of(Event::CheckedMessage)
      events[1].should be_instance_of(Event::NewMessage)
    end
  end
  
  describe "#unordered" do
    it "should aggregate new message and checked delivery events" do
      @user = create(:user)

      checked_message = create(:delivered_message, user: @user)
      @user.messages << checked_message

      unordered_events = Event::Builder.new(@user).unordered

      unordered_events[0].should be_instance_of(Event::NewMessage)
      unordered_events[1].should be_instance_of(Event::CheckedMessage) 
    end
  end
end