module EventsHelper
  def partial_for_event(event)
    render "shared/events/#{event.class.name.demodulize.underscore}", event: event
  end

  def linked_student_names(students)
    student_links = students.map { |student|
      link_to student.full_name, preview_student_path(student), remote: true
    }
    student_links.to_sentence.html_safe
  end

  def checked_message_copy(message)
    #TODO: message.deliveries.count should be cached in messages table to avoid lookup.
    # However, this is only called when a mass message is sent, which we don't
    # expect to happen more than maybe once a week per user
    parents_copy = message.individual? \
      ? "#{message.students.first.full_name}'s parent checked" \
      : "#{message.checked_deliveries.count} of #{pluralize(message.deliveries.count, 'parent')} have checked"

    "#{parents_copy} #{link_to truncate(message.body, length: 30), message_path(message), remote: true}".html_safe
  end
end