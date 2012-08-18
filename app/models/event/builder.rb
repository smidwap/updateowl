class Event::Builder
  attr_accessor :user, :events

  def initialize(user)
    @user = user
  end

  def events
    unordered.sort_by { |event| -event.time.to_i }
  end

  def unordered
    new_messages + checked_deliveries + new_parents
  end

  private

  def new_messages
    @user.messages.map { |message| Event::NewMessage.new(message) }
  end

  def checked_deliveries
    @user.deliveries.successful.all.map { |delivery| Event::CheckedMessage.new(delivery) }
  end

  def new_parents
    @user.parents.map { |parent| Event::NewParent.new(@user, parent) }
  end
end