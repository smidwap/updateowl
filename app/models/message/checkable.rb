module Message::Checkable
  extend ActiveSupport::Concern

  # Creates an array like [[0, 0.125], ..., [.875, 1.0]]
  OCTILE_INTERVALS = 8.times.inject([]) do |intervals, index|
    lower_bound = index * 0.125
    upper_bound = 0.125 + index * 0.125
    intervals << [lower_bound, upper_bound]
    intervals
  end

  included do
    scope :checked, where('checks_count > 0')
    scope :unchecked, where('checks_count = 0')
  end

  def checked?
    checks_count > 0
  end

  def percentage_checked_octile
    percentage_checked == 0 ? 0 : index_of_interval_with_percentage_checked + 1
  end

  def percentage_checked
    checks_count.to_f / student_messages_count
  end

private

  def index_of_interval_with_percentage_checked
    interval_with_percentage_checked = OCTILE_INTERVALS.select { |interval|
      percentage_checked > interval[0] && percentage_checked <= interval[1]
    }.first
    OCTILE_INTERVALS.index(interval_with_percentage_checked)
  end
end