module Ajax
  extend ActiveSupport::Concern

  included do
    before_filter :discard_flash
  end

  def render_resource_invalid(resource)
    message = "Something's wrong with your form: " + resource.errors.full_messages.to_sentence
    render text: message, status: 403
  end

  private

  def discard_flash
    flash.discard if request.xhr?
  end
end