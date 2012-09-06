module Parental
  module Phone
    class DeliveriesController < BaseController
      load_resource except: :index
      before_filter :set_locale_from_delivery, except: :index

      def index
        @parent = Parent.find(params[:parent_id])

        set_locale_of @parent

        track_index
      end

      def show
        @delivery.checked!

        track_show
      end

      def next
        redirect_to parental_phone_delivery_path(@delivery.next_delivery)
      end

      def route
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

      def set_locale_from_delivery
        set_locale_of @delivery.parent
      end

      def set_locale_of(parent)
        I18n.locale = parent.locale
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