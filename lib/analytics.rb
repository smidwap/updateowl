module Analytics
  extend ActiveSupport::Concern

  protected

  def track_event(event, properties={})
    $mixpanel_event_builder.build_and_queue_event(event, properties)
  end

  def with_current_user(user)
    $mixpanel_event_builder.current_user = user
    yield
    $mixpanel_event_builder.current_user = nil
  end

  def track_parent_event(parent, event, properties = {})
    default_properties = {
      "distinct_id" => "Parent - #{parent.id}",
      "mp_name_tag" => "Parent #{parent.current_contact}",
      "Preference" => parent.preference,
      "School" => @parent.try(:school).try(:name)
    }

    track_event(event, default_properties.merge(properties))
  end

  def set_people_properties(properties = {})
    $mixpanel_event_builder.build_and_queue_people_data({
      "$set" => properties
    })
  end

  def increment_people_property(property, increment = 1)
    $mixpanel_event_builder.build_and_queue_people_data({
      "$add" => {
        "#{property}" => increment
      }
    })
  end

  def user_distinct_id(user)
    "User - #{user.id}"
  end
end

ActiveRecord::Base.send(:include, Analytics)
ActiveRecord::Observer.send(:include, Analytics)
ActionController::Base.send(:include, Analytics)