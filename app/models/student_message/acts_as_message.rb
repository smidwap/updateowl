module StudentMessage::ActsAsMessage
  extend ActiveSupport::Concern

  included do
    scope :checked, where('checked_at IS NOT NULL')
    scope :unchecked, where('checked_at IS NULL')
    scope :from_user, lambda { |users| joins(:message).merge(Message.from_user(users)) }
  end

  def checked?
    checked_at?
  end

private

  # Delegate to the message model if the method is missing
  def method_missing(method, *args, &block)
    message.send(method, *args, &block)
  end
end