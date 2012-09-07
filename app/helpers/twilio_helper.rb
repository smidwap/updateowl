module TwilioHelper
  def say(attributes = {}, &block)
    defaults = {
      language: I18n.locale
    }

    content_tag("Say", defaults.merge(attributes)) { block.call }
  end
end