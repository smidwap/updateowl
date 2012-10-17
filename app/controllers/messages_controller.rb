class MessagesController < ApplicationController
  load_and_authorize_resource
  protect_from_forgery except: :create

  layout "second_tier_page"

  def show
  end

  def create
    @message = Message.new(params[:message])

    authorize! :manage, @message

    @message.save!
    @message.reload
  rescue ActiveRecord::RecordInvalid
    render_resource_invalid @message
  end
end