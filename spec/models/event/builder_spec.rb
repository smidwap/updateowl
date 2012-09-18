require 'spec_helper'

describe Event::Builder do
  describe "#events" do
    it "should sort unordered events by most recent first" do
      @user = build_stubbed(:user)
      builder = Event::Builder.new(@user)

      new_message = Event::NewMessage.new(build_stubbed(:message))
      new_message.time = 3.days.ago

      checked_individual_message = Event::CheckedMessage.new(create(:delivered_individual_message))
      checked_individual_message.time = Time.now

      builder.stub(:new_messages).and_return [new_message]
      builder.stub(:checked_messages).and_return [checked_individual_message]

      events = builder.events

      events[0].should be_instance_of(Event::CheckedMessage)
      events[1].should be_instance_of(Event::NewMessage)
    end
  end
  
  describe "event types" do
    before(:each) do
      @user = create(:user)

      @builder = Event::Builder.new(@user)
    end

    describe "#new_messages" do
      it "should return new message events for each message sent for the user's students" do
        student = create(:student)

        student.messages << create(:message, user: @user)
        student.messages << create(:message) # Different user

        @user.students << student

        @builder.new_messages.count.should == 2
        @builder.new_messages.each do |event|
          event.should be_instance_of(Event::NewMessage)
        end
      end
    end

    describe "#checked_messages" do
      it "should return events for each checked individual message" do
        checked_individual_message = create(:delivered_individual_message, user: @user)
        checked_mass_message = create(:delivered_mass_message, user: @user)

        @builder.checked_messages.count.should == 2
        @builder.checked_messages.first.should be_instance_of(Event::CheckedMessage)
      end
    end

    describe "#new_parents" do
      it "should return new parent events for each accessible parent" do
        student = create(:student_with_parent)
        @user.students << student

        @builder.new_parents.count.should == student.parents.count
        @builder.new_parents.each do |event|
          event.should be_instance_of(Event::NewParent)
        end
      end
    end
  end
end