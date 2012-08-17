module CurrentUser
  extend ActiveSupport::Concern

  included do
    around_filter :thread_current_user
  end

  private

  def thread_current_user
    Thread.current[:user] = current_user
    yield
    Thread.current[:user] = nil
  end
end