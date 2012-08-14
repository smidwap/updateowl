module Parental
  module Web
    class BaseController < ApplicationController
      skip_before_filter :authenticate_user!
    end
  end
end