class HomeController < ApplicationController
  def dashboard
    sign_in(:user, User.first)
    redirect_to user_path(current_user)
  end
end
