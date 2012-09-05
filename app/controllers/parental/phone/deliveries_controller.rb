module Parental
  module Phone
    class DeliveriesController < BaseController
      after_filter :set_locale

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

      def set_locale
        I18n.locale = @parent.present? ? @parent.locale : @delivery.parent.locale
        I18n.locale = :en
      end

      def track_index
        Analytics.track_parent_event @parent, "Phone Call: Main Menu"
      end

      def track_show
        Analytics.track_parent_event @delivery.parent, "Phone Call: Hear Update"
      end

      def track_repeat
        Analytics.track_parent_event @delivery.parent, "Phone Call: Repeat Update"
      end

      def track_next
        Analytics.track_parent_event @delivery.parent, "Phone Call: Next Update"
      end
    end
  end
end