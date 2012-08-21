class MessageObserver < ActiveRecord::Observer
  def after_create(message)
    track_event "Update: Sent", {
      "Student ID" => message.student_id,
      "Student Name" => message.student.full_name,
      "Message Length" => message.body.length,
      "School" => message.user.school.name
    }

    increment_people_property("Updates Sent")

    set_people_properties({
      "Last Update Sent" => message.created_at
    })
  end
end