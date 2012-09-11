module Parental
  module Phone
    class DeliveriesController < BaseController
      load_resource except: [:index, :voicemail]
      before_filter :set_locale_from_delivery, except: [:index, :voicemail]

      def index
        @parent = Parent.find(params[:parent_id])

        check_voicemail

        set_locale_of @parent

        track_index
      end
      
      def voicemail
        @parent = Parent.find(params[:parent_id])

        set_locale_of @parent

        track_voicemail
      end

      def show
        @delivery.checked!

        track_show
      end

      def next
        redirect_to parental_phone_delivery_path(@delivery.next_delivery)
      end

      def feedback
        track_feedback
      end

      def route
        case params[:Digits]
        when "1"
          track_repeat

          redirect_to parental_phone_delivery_path(@delivery)
        when "2"
          track_next

          redirect_to next_parental_phone_delivery_path(@delivery)
        when "3"
          redirect_to feedback_parental_phone_delivery_path(@delivery)
        end
      end

    private

      def check_voicemail
        redirect_to voicemail_parental_phone_parent_deliveries_path(@parent) if params[:AnsweredBy] == "machine"
      end

      def set_locale_from_delivery
        set_locale_of @delivery.parent
      end

      def set_locale_of(parent)
        I18n.locale = parent.locale
      end

      def track_index
        Analytics.track_parent_event @parent, "Phone Call: Main Menu"
      end

      def track_voicemail
        Analytics.track_parent_event @parent, "Phone Call: Voicemail Reached"
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

      def track_feedback
        Analytics.track_parent_event @delivery.parent, "Update: Poor Translation"
      end
    end
  end
end