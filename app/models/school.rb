class School < ActiveRecord::Base
  has_many :grade_levels
  has_many :students, through: :grade_levels

  has_many :users
  has_many :messages, through: :users

  has_many :parents

  attr_accessible :name

  def weekly_message_count_averages(num_trailing_weeks = 1)
    num_active_users = users.has_sent_a_message_since(5.weeks.ago.beginning_of_week).length

    counts = num_trailing_weeks.times.inject([]) do |counts, index|
      counts << messages.weeks_ago(index).count / num_active_users
    end
  rescue ZeroDivisionError
    num_trailing_weeks.times.inject([]) { |averages| averages << 0 }
  end
end
