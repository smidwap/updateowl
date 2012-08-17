class ApplicationController < ActionController::Base
  include Ajax
  include CurrentUser
    
  protect_from_forgery

  before_filter :authenticate_user!
end
