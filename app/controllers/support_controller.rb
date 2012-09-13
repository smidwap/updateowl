class SupportController < ApplicationController
  layout "second_tier_page"
  
  def new
  end

  def create
    SupportMailer.support_request(
      requestor: current_user,
      request: params[:request]
    ).deliver
  end
end