module Analytics
  def self.track_event(event, properties={})
    $mixpanel_event_builder.build_and_queue_event(event, properties)
  end

  def self.with_current_user(user)
    $mixpanel_event_builder.current_user = user
    yield
    $mixpanel_event_builder.current_user = nil
  end

  def self.track_parent_event(parent, event, properties = {})
    default_properties = {
      "distinct_id" => "Parent - #{parent.id}",
      "mp_name_tag" => "Parent #{parent.current_contact}",
      "Preference" => parent.preference,
      "School" => parent.try(:school).try(:name)
    }

    track_event(event, default_properties.merge(properties))
  end

  def self.track_delivery_event(delivery, event, properties = {})
    default_properties = {
      "distinct_id" => "Delivery - #{delivery.id}",
      "mp_name_tag" => "Delivery #{delivery.id}",
      "School" => delivery.school.name,
      "Grade Levels" => delivery.student.grade_level.name,
      "Translated" => delivery.parent.spanish_speaking?,
      "Mass Update" => !delivery.message.individual?,
      "Via" => delivery.parent.preference
    }

    track_event(event, default_properties.merge(properties))
  end

  def self.set_people_properties(properties = {})
    $mixpanel_event_builder.build_and_queue_people_data({
      "$set" => properties
    })
  end

  def self.increment_people_property(property, increment = 1)
    $mixpanel_event_builder.build_and_queue_people_data({
      "$add" => {
        "#{property}" => increment
      }
    })
  end

  def self.user_distinct_id(user)
    "User - #{user.id}"
  end
end