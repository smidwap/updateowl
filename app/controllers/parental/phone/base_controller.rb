module Parental
  module Phone
    class ParentNotFound < StandardError; end

    class BaseController < ApplicationController
      skip_before_filter :authenticate_user!
      before_filter :set_request_format

      private

      def set_request_format
        request.format = "xml"
      end
    end
  end
end