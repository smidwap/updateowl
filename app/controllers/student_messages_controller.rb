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
    @student = Student.find(params[:student_id])
    @message = Message.new
    @message.student = @student
    @message.user = current_user

    authorize! :manage, @message
  end

  def create
    @student = Student.find(params[:student_id])
    @message = @student.messages.new(params[:message])

    authorize! :manage, @message

    @message.save!

    @event = Event::NewMessage.new(@message)
  rescue ActiveRecord::RecordInvalid
    render_resource_invalid @message
  end
end
