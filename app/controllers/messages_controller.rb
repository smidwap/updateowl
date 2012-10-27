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

    track_create_if_sent_from_extension
  rescue ActiveRecord::RecordInvalid
    render_resource_invalid @message
  end

private

  def track_create_if_sent_from_extension
    if params[:format] == 'extension'
      Analytics.track_event 'Update: Sent from Extension', {
        "School" => @message.school.name,
        "Grade Levels" => @message.grade_levels.map(&:name),
        "Teacher" => @message.user.full_name,
      }
    end
  end
end