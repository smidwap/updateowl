module Phone
  class ParentsController < BaseController
    before_filter :load_and_authorize_parent

    def answer
      redirect_to phone_parent_deliveries_path(@parent)
    end

    private

    def load_and_authorize_parent
      phone = params[:Direction] == "outbound-api" ? params[:To] : params[:From]
      @parent = Parent.find_by_phone(phone)

      raise ParentNotFound, "The parent with number '#{params[:To]}' is not in the database." unless @parent
    end
  end
end