class UserObserver < ActiveRecord::Observer
  def after_create(user)
    track_event "User: Registered", {
      "distinct_id" => user_distinct_id(user),
      "mp_name_tag" => user.full_name
    }
    track_event "$signup", {
      "distinct_id" => user_distinct_id(user),
      "mp_name_tag" => user.full_name
    }
  end

  def after_update(user)
    if user.last_sign_in_at_changed?
      track_event "User: Sign In", {
        "distinct_id" => user_distinct_id(user) # No current user is saved in a thread yet
      }
    end
  end
end