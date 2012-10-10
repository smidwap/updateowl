require 'spec_helper'

describe Event::Builder do
  describe "#events" do
    it "should sort unordered events by most recent first" do
      builder = Event::Builder.new(build_stubbed(:user))

      oldest_event = Event::NewMessage.new(build_stubbed(:message))
      oldest_event.time = 1.week.ago

      most_recent_event = Event::NewMessage.new(build_stubbed(:message))
      most_recent_event.time = 1.day.ago
      events = [oldest_event, most_recent_event]

      builder.stub(:unsorted_events).and_return(events)

      builder.events.should == [most_recent_event, oldest_event]
    end
  end
end