class Event::Builder
  attr_accessor :user, :events

  def initialize(user)
    @user = user
  end

  def events
    unordered = new_messages + checked_messages + new_parents
    unordered.sort_by { |event| -event.time.to_i }
  end

  def new_messages
    @user.student_messages.includes(:students, :user).map { |message| Event::NewMessage.new(message) }
  end

  def checked_messages
    @user.messages.checked.includes(:students, :checked_deliveries).all.map { |message| Event::CheckedMessage.new(message) }
  end

  def new_parents
    @user.parents.includes(:students).map { |parent| Event::NewParent.new(@user, parent) }
  end
end