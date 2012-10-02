class Consistency
  NUM_TRAILING_WEEKS = 5
  COMPARISON_TYPES = [School, User]

  attr_accessor :primary, :comparison

  def initialize(primary, comparison = nil)
    self.primary = primary
    self.comparison = comparison if comparison
    self
  end

  def goal
    10
  end

  def stats
    @stats ||= calculate_stats
  end

  def is_a_comparison?
    comparison.present?
  end

private

  def calculate_stats
    stats = {}
    stats[:primary] = stats_for(primary)
    stats[:comparison] = stats_for(comparison) if is_a_comparison?
    stats
  end

  def stats_for(entity)
    message_counts = message_counts_for(entity)

    {
      this_week: message_counts[-1],
      last_week: message_counts[-2],
      average: message_counts.inject(:+).to_i / max_or_num_weeks_since_first_message,
      counts: message_counts
    }
  end

  def message_counts_for(entity)
    case entity
    when School
      entity.weekly_message_count_averages(NUM_TRAILING_WEEKS).reverse
    when User
      entity.weekly_message_counts(NUM_TRAILING_WEEKS).reverse
    end
  end

  def max_or_num_weeks_since_first_message
    num_weeks_since_first_message = NUM_TRAILING_WEEKS - primary.school.weekly_message_count_averages(NUM_TRAILING_WEEKS).reverse.find_index { |x| x != 0 }
    num_weeks_since_first_message > NUM_TRAILING_WEEKS ? NUM_TRAILING_WEEKS : num_weeks_since_first_message
  end

  def valid_comparison_type?(comparison)
    COMPARISON_TYPES.include?(comparison.class)
  end
end