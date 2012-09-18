class Event::CheckedMessage < Event::Base
  attr_accessor :message

  def initialize(message)
    @message = message
    @time = message.checked_deliveries.first.delivered_at
  end
end