module Message::Translatable
  extend ActiveSupport::Concern

  included do
    after_create :translate, if: :should_translate?
    after_update :translate, if: :should_retranslate?
  end

  def translate
    Resque.enqueue(MessageTranslator, id)
  end

  def spanish_body
    self[:spanish_body] || MessageTranslator.new(self).translation
  end

private

  def should_translate?
    recipients.spanish_speaking.count > 0
  end

  def should_retranslate?
    should_translate? && body_changed?
  end
end