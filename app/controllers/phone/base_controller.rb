module Phone
  class ParentNotFound < StandardError; end

  class BaseController < ApplicationController
    skip_before_filter :authenticate_user!
  end
end