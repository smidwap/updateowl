class Event::CheckedMessage < Event::Base
  attr_accessor :message

  def initialize(message)
    @message = message
    @time = message.checked_deliveries.first.checked_at
  end
end