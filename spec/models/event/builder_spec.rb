require 'spec_helper'

describe Event::Builder do
  describe "#events" do
    it "should sort unordered events by most recent first" do
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
    it "should aggregate new message, checked delivery, and new parent events" do
      @user = create(:user)

      # Create data for new message & checked delivery events
      checked_message = create(:delivered_message, user: @user)
      @user.messages << checked_message

      # Create data for new parent events
      student = create(:student)
      @user.students << student

      parent = create(:parent)
      student.parents << parent

      unordered_events = Event::Builder.new(@user).unordered

      unordered_events[0].should be_instance_of(Event::NewMessage)
      unordered_events[1].should be_instance_of(Event::CheckedMessage) 
      unordered_events[2].should be_instance_of(Event::NewParent)
    end
  end
end