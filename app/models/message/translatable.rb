module Message::Translatable
  extend ActiveSupport::Concern

  included do
    after_commit :translate, if: :requires_translation?
    after_update :translate, if: :should_retranslate?
  end

  def translate
    Resque.enqueue(MessageTranslator, id)
  end

  def spanish_body
    self[:spanish_body] || MessageTranslator.new(self).translation
  end

  def requires_translation?
    if new_record?
      Parent.spanish_speaking.of_students(students).count > 0
    else
      recipients.spanish_speaking.count > 0
    end
  end

private

  def should_retranslate?
    return false unless body_changed?
    requires_translation?
  end
end