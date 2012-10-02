class School < ActiveRecord::Base
  has_many :grade_levels
  has_many :students, through: :grade_levels

  has_many :users
  has_many :messages, through: :users

  has_many :parents

  attr_accessible :name

  def weekly_message_count_averages(num_trailing_weeks = 1)
    num_active_users = users.has_sent_a_message_since(num_trailing_weeks.weeks.ago.beginning_of_week).length

    weekly_message_counts(num_trailing_weeks).inject([]) do |average_counts, weekly_count|
      average_counts << weekly_count / num_active_users
    end
  rescue ZeroDivisionError
    num_trailing_weeks.times.inject([]) { |averages| averages << 0 }
  end

  def weekly_message_counts(num_trailing_weeks = 1)
    num_trailing_weeks.times.inject([]) do |counts, index|
      counts << messages.weeks_ago(index).count
    end
  end

  class NoMessagesSent < StandardError; end

  def num_weeks_since_first_message
    first_message = messages.earliest_first.first

    raise NoMessagesSent unless first_message.present?

    unrounded = ((Time.now.beginning_of_week.to_f -  first_message.created_at.beginning_of_week.to_f) / 1.week.seconds) + 1
    unrounded.round
  end
end
