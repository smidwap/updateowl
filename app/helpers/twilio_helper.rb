module TwilioHelper
  def say(&block)
    content_tag("Say", language: I18n.locale) { block.call }
  end
end