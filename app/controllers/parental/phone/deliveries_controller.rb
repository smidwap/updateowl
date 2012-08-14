module Parental
  module Phone
    class DeliveriesController < BaseController
      def index
        @parent = Parent.find(params[:parent_id])
      end

      def show
        @delivery = Delivery.find(params[:id])
        @delivery.checked!
      end

      def next
        @delivery = Delivery.find(params[:id])

        redirect_to parental_phone_delivery_path(@delivery.next_delivery)
      end

      def route
        @delivery = Delivery.find(params[:id])

        case params[:Digits]
        when "1"
          redirect_to parental_phone_delivery_path(@delivery)
        when "2"
          redirect_to next_parental_phone_delivery_path(@delivery)
        end        
      end
    end
  end
end