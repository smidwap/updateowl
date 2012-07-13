class HomeController < ApplicationController
  def dashboard
    sign_in(:user, User.first)
  end
end
