module Phone
  class DeliveriesController < BaseController
    #before_filter :load_and_authorize_parent
    before_filter :set_request_format

    def index
      @parent = Parent.find_by_phone(params[:To])
    end

    def show
      @delivery = Delivery.find(params[:id])
      @delivery.checked!
    end

    def next
      @delivery = Delivery.find(params[:id])

      redirect_to phone_delivery_path(@delivery.next_delivery)
    end

    def route
      @delivery = Delivery.find(params[:id])

      case params[:Digits]
      when "1"
        redirect_to phone_delivery_path(@delivery)
      when "2"
        redirect_to next_phone_delivery_path(@delivery)
      end        
    end

    private

    def load_and_authorize_parent
      @parent = Parent.find_by_phone(params[:To])

      raise ParentNotFound, "The parent with number '#{params[:To]}' is not in the database." unless @parent
    end

    def set_request_format
      request.format = "xml"
    end
  end
end