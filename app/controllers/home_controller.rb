class HomeController < ApplicationController
  layout "users"

  def dashboard
    @user = current_user
  end
end
