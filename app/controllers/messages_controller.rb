class MessagesController < ApplicationController
  load_and_authorize_resource

  layout "second_tier_page"

  def show
  end

  def create
    @message = Message.new(params[:message])

    authorize! :manage, @message

    @message.save!
  rescue ActiveRecord::RecordInvalid
    render_resource_invalid @message
  end
end