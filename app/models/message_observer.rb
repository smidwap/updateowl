class MessageObserver < ActiveRecord::Observer
  def after_create(message)
    Analytics.track_event "Update: Sent", {
      "Message Length" => message.body.length,
      "School" => message.school.name,
      "Grade Levels" => message.grade_levels.map(&:name),
      "Teacher" => message.user.full_name,
      "Mass Update" => !message.individual?,
      "Translated" => message.requires_translation?
    }
  end
end