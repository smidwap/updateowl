class MessagesController < ApplicationController
  load_and_authorize_resource except: [:new, :create]

  layout 'second_tier_page'

  def new
    @student = Student.find(params[:student_id])
    @message = Message.new
    @message.student = @student
    @message.sender = current_user

    authorize! :manage, @message
  end

  def create
    @student = Student.find(params[:student_id])
    @message = @student.messages.new(params[:message])

    authorize! :manage, @message

    @message.save!
  rescue ActiveRecord::RecordInvalid
    render :new
  end
end
