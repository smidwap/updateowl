class StudentMessagesController < ApplicationController
  load_and_authorize_resource :student

  layout "second_tier_page"

  def index
    render layout: "students"
  end

  def user
    @user = User.find(params[:user_id])

    authorize! :read, @user

    render layout: "students"
  end

  def unchecked
    render layout: "students"
  end

  def new
    @message = @student.messages.new #FIX
    @message.user = current_user

    authorize! :manage, @message
  end

  def create
    @message = Message.new(params[:message])
    @message.students << @student

    authorize! :manage, @message

    @message.save!

    @event = Event::NewMessage.new(@message)
  rescue ActiveRecord::RecordInvalid
    render_resource_invalid @message
  end
end
