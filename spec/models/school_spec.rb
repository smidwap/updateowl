require 'spec_helper'

describe School do
  before(:each) do
    @school = create(:school)
  end

  describe "#weekly_message_count_averages" do
    it "should return averages based on the number of users who have sent at least 1 message" do
      average_num_this_week = 2
      average_num_last_week = 3

      @active_user = create(:user, school: @school)
      @another_active_user = create(:user, school: @school)
      @inactive_user = create(:user, school: @school)

      create_list(:message, average_num_this_week, user: @active_user)
      create_list(:message, average_num_last_week, user: @active_user).each do |message|
        message.update_column(:created_at, 1.week.ago.beginning_of_week)
      end

      create_list(:message, average_num_this_week, user: @another_active_user)
      create_list(:message, average_num_last_week, user: @another_active_user).each do |message|
        message.update_column(:created_at, 1.week.ago.beginning_of_week)
      end

      create_list(:message, 2, user: @inactive_user).each do |message|
        message.update_column(:created_at, 6.week.ago.beginning_of_week)
      end        

      @school.weekly_message_count_averages(6).should == [average_num_this_week, average_num_last_week, 0, 0, 0, 0]
    end

    it "should not fail when 0 teachers have sent messages in the past 5 weeks" do
      @school.weekly_message_count_averages(6).should == [0, 0, 0, 0, 0, 0]
    end
  end
end
