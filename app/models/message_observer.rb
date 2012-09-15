class MessageObserver < ActiveRecord::Observer
  def after_create(message)
    Analytics.track_event "Update: Sent", {
      "Student ID" => message.student_id,
      "Student Name" => message.student.full_name,
      "Message Length" => message.body.length,
      "School" => message.school.name,
      "Grade Level" => "#{message.school.name} - #{message.grade_level.name}",
      "Teacher" => message.user.full_name
    }
  end
end