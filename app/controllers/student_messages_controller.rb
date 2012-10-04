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
    @message = @student.messages.new
    @message.user = current_user
    @message.students << @student

    authorize! :manage, @message
  end

private

  after_filter :track_index, only: :index

  def track_index
    Analytics.track_event "Student Messages: View", {
      "School" => @student.school.name
    }
  end
end
