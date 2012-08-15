module EventsHelper
  def partial_for_event(event)
    render "shared/events/#{event.class.name.demodulize.underscore}", event: event
  end
end