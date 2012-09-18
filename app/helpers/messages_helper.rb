module MessagesHelper
  def why_limit_length_link
    link_to "Why?", "#", data: {
      behavior: 'popover',
      title: 'Why keep updates short?',
      content: '<ul>
          <li>Long updates are a sign that a more thorough conversation is required.</li>
          <li>Updates may be read over the phone, and long updates are hard to follow!</li>
          <li>Updates are designed to be sent frequently.</li>
        </ul>',
      placement: 'top'
    }
  end

  def message_translation_note(message)
    note = if message.individual?
        "This update will be <b>translated to Spanish</b>. Keep it simple!"
      else
        "This update will be <b>translated to Spanish</b> for some parents. Keep it simple!"
      end
    note.html_safe
  end

  def message_placeholder(message)
    message.individual? ? "Update #{message.students.first.full_name}'s parents" : "Update everyone's parents..."
  end

  def student_name_for_message(message)
    message.individual? ? message.students.first.full_name : "All Students"
  end
end