module HasManyMessages
  extend ActiveSupport::Concern

  def num_messages_last_week
    messages.last_week.all.count
  end
  
  def num_messages_unchecked
    messages.unchecked.count
  end
end