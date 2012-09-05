module Parental
  module Web
    class DeliveriesController < BaseController
      def show
        @delivery = Delivery.find_by_access_code(params[:access_code])
        @delivery.checked!

        I18n.locale = @delivery.parent.locale
      end
    end
  end
end