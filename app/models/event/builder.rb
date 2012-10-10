class Event::Builder
  attr_accessor :user

  def initialize(user)
    self.user = user
  end

  def events
    @events ||= unsorted_events.sort_by { |event| -event.time.to_i }
  end

  def new_message_events
    new_messages.map { |message| Event::NewMessage.new(message) }
  end

  def checked_message_events
    checked_messages.map { |message| Event::CheckedMessage.new(message) }
  end

  def new_parent_events
    new_parents.map { |parent| Event::NewParent.new(user, parent) }
  end

private

  def unsorted_events
    new_message_events + checked_message_events + new_parent_events
  end

  def new_messages
    user.all_messages_for_students.includes(:students, :user)
  end

  def checked_messages
    user.messages.checked.includes(:students)
  end

  def new_parents
    user.parents_of_students.includes(:students)
  end
end