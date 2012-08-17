module Analytics
  extend ActiveSupport::Concern

  protected

  def track_event(event, properties={})
    $mixpanel_event_builder.build_and_queue_event(event, properties)
  end
end

ActiveRecord::Base.send(:include, Analytics)
ActiveRecord::Observer.send(:include, Analytics)
ActionController::Base.send(:include, Analytics)