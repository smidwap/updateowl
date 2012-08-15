module HomeHelper
  def partial_for_event(event)
    render event.class.name.demodulize.underscore, event: event
  end
end