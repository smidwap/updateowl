module Ajax
  extend ActiveSupport::Concern

  included do
    before_filter :discard_flash
  end

  private

  def discard_flash
    flash.discard if request.xhr?
  end
end