class Event::NewMessage < Event::Base
  attr_accessor :message

  def initialize(message)
    @message = message
    @time = message.created_at
  end
end