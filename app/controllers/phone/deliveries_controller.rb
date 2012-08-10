module Phone
  class DeliveriesController < BaseController    
    before_filter :load_and_authorize_parent
    before_filter :set_request_format

    def index
    end

    private

    def load_and_authorize_parent
      params[:Digits] = '+12193090213'

      @parent = Parent.find_by_phone(params[:Digits])

      raise ParentNotFound, "The parent with number '#{params[:Digits]}' is not in the database." unless @parent
    end

    def set_request_format
      request.format = "xml"
    end
  end
end