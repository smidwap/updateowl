module Message::Translatable
  extend ActiveSupport::Concern

  included do
    after_create :translate, if: :requires_translation?
    after_update :translate, if: :should_retranslate?
  end

  def translate
    Resque.enqueue(MessageTranslator, id)
  end

  def spanish_body
    self[:spanish_body] || MessageTranslator.new(self).translation
  end

  def requires_translation?
    Parent.of_students(students).spanish_speaking.count > 0
  end

private

  def should_retranslate?
    requires_translation? && body_changed?
  end
end