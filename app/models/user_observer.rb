class UserObserver < ActiveRecord::Observer
  def after_create(user)
    Analytics.with_current_user(user) do
      Analytics.track_event "User: Registered"
      Analytics.track_event "$signup"

      Analytics.set_people_properties({
        "$first_name" => user.first_name,
        "$last_name" => user.last_name,
        "$email" => user.email,
        "$created" => user.created_at,
        "School" => user.school.name
      })
    end
  end

  def after_update(user)
    if user.last_sign_in_at_changed?
      Analytics.with_current_user(user) do
        Analytics.track_event "User: Sign In"

        Analytics.set_people_properties({
          "$last_login" => Time.now
        })
      end
    end
  end
end