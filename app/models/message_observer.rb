class MessageObserver < ActiveRecord::Observer
  def after_create(message)
    track_event "Update: Sent", {
      "Student ID" => message.student_id,
      "Student Name" => message.student.full_name,
      "Message Length" => message.body.length
    }

    increment_people_property("Updates Sent")
  end
end