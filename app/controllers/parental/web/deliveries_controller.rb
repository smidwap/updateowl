module Parental
  module Web
    class DeliveriesController < BaseController
      def index
        @deliveries = Delivery.with_access_codes(params[:c]).latest_first
        @deliveries.each(&:checked!)

        I18n.locale = @deliveries.first.parent.locale
      end

      def feedback
        @delivery = Delivery.find_by_access_code(params[:id])

        Analytics.track_parent_event @delivery.parent, "Update: Poor Translation", {
          "Message ID" => @delivery.message_id
        }
      end
    end
  end
end