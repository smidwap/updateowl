class UserObserver < ActiveRecord::Observer
  def after_create(user)
    track_event "User: Registered", {
      "distinct_id" => user.id,
      "mp_name_tag" => user.full_name
    }
  end
end