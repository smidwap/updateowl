module MessagesHelper
  CHECKMARK_CLASSES = [
    'checked_by_12_point_5_percent',
    'checked_by_25_percent', 
    'checked_by_37_point_5_percent',
    'checked_by_50_percent',
    'checked_by_62_point_5_percent',
    'checked_by_75_percent',
    'checked_by_87_point_5_percent',
    'checked_by_100_percent'
  ]

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
    message.individual? ? "Update #{message.students.first.full_name}'s parents" : "Update everyone's parents"
  end

  def student_name_for_message(message)
    message.individual? ? message.students.first.full_name : "All Students"
  end

  # We assume the message is checked here
  def message_checkmark_class(message)
    return "checked_by_100_percent" if message.individual? || message.kind_of?(StudentMessage)

    CHECKMARK_CLASSES[message.percentage_checked_octile - 1]
  end

  # When the message is of type StudentMessage, the message
  # template differs between mass messages and individual
  # messages.
  def message_cache_key(message)
    if message.kind_of?(Message)
      message.cache_key
    else
      if message.individual?
        message.message.cache_key
      else
        message.cache_key
      end
    end
  end
end