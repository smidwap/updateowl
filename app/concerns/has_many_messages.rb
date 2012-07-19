module HasManyMessages
  extend ActiveSupport::Concern

  included do
    has_many :messages, order: "created_at DESC"
  end

  def num_messages_last_week
    messages.last_week.count
  end
  
  def num_messages_unchecked
    1
  end
end