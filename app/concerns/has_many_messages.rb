module HasManyMessages
  extend ActiveSupport::Concern

  included do
    has_many :messages, order: "created_at DESC", dependent: :destroy
    has_many :deliveries, through: :messages, dependent: :destroy
  end

  def num_messages_last_week
    messages.last_week.all.count
  end
  
  def num_messages_unchecked
    messages.unchecked.count
  end
end