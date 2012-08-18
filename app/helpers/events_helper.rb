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

  private
end