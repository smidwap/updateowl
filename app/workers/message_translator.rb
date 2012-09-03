class MessageTranslator
  @queue = :message_translator

  attr_accessor :message
  attr_writer :translation

  def initialize(message)
    @message = message

    self
  end

  def translate
    @message.spanish_body = translation
    @message.save!
  end

  def translation
    @translation ||= @message.body.to_spanish
  end

  def self.perform(id)
    message = Message.find(id)

    self.new(message).translate
  end
end