class UserMessagesController < ApplicationController
  load_and_authorize_resource :user

  layout "users"

  def index
  end

  def last_week
  end

  def unchecked
  end
end