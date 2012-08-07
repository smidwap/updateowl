module Email
  class DeliveriesController < BaseController
    def show
      @delivery = Delivery.find_by_access_code(params[:access_code])
    end
  end
end