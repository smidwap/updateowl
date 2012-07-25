class ApplicationController < ActionController::Base
  include Ajax
    
  protect_from_forgery

  before_filter :authenticate_user!
end
