class MessageObserver < ActiveRecord::Observer
  def after_create(message)
    grade_level = message.students.first.grade_level

    Analytics.track_event "Update: Sent", {
      "Message Length" => message.body.length,
      "School" => message.school.name,
      "Grade Level" => "#{message.school.name} - #{grade_level}",
      "Teacher" => message.user.full_name
    }
  end
end