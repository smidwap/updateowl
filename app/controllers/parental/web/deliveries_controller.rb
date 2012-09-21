module Parental
  module Web
    class DeliveriesController < BaseController
      def show
        @delivery = Delivery.find_by_access_code(params[:id])
        @delivery.checked!

        I18n.locale = @delivery.parent.locale
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