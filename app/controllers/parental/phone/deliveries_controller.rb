module Parental
  module Phone
    class DeliveriesController < BaseController
      def index
        @parent = Parent.find(params[:parent_id])

        track_index
      end

      def show
        @delivery = Delivery.find(params[:id])
        @delivery.checked!

        track_show
      end

      def next
        @delivery = Delivery.find(params[:id])

        redirect_to parental_phone_delivery_path(@delivery.next_delivery)
      end

      def route
        @delivery = Delivery.find(params[:id])

        case params[:Digits]
        when "1"
          track_repeat

          redirect_to parental_phone_delivery_path(@delivery)
        when "2"
          track_next

          redirect_to next_parental_phone_delivery_path(@delivery)
        end        
      end

      private

      def track_index
        track_parent_event @parent, "Phone Call: Main Menu"
      end

      def track_show
        track_parent_event @delivery.parent, "Phone Call: Hear Update"
      end

      def track_repeat
        track_parent_event @delivery.parent, "Phone Call: Repeat Update"
      end

      def track_next
        track_parent_event @delivery.parent, "Phone Call: Next Update"
      end
    end
  end
end