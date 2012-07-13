module User::Stats
  extend ActiveSupport::Concern

  def num_messages_last_week
    messages_last_week.count
  end

  def num_messages_unchecked
    1
  end
end