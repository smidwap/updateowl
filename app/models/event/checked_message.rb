class Event::CheckedMessage < Event::Base
  attr_accessor :message

  def initialize(delivery)
    @message = delivery.message
    @time = delivery.delivered_at
  end
end