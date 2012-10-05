module Parental
  module Web
    class DeliveriesController < BaseController
      def index
        @deliveries = Delivery.with_access_codes(params[:c]).latest_first
        @deliveries.each(&:checked!)

        I18n.locale = @deliveries.first.parent.locale
      end

      def show
        @delivery = Delivery.find_by_access_code(params[:id])
        @delivery.checked!

        I18n.locale = @delivery.parent.locale
      end

      def feedback
        @delivery = Delivery.find_by_access_code(params[:id])

        head :ok
      end

    private

      after_filter :track_feedback, only: :feedback

      def track_feedback
        Analytics.track_parent_event @delivery.parent, "Update: Poor Translation", {
          "Message ID" => @delivery.message_id
        }
      end
    end
  end
end