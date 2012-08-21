class MixpanelEventBuilder
  include Analytics

  attr_accessor :token
  attr_writer :current_user

  def initialize(token)
    @token = token
  end

  def build_and_queue_event(event, properties={})
    properties["token"] = @token
    properties = user_properties.merge(properties)

    if !properties.has_key?("token")
      raise "Token is required"
    end

    Resque.enqueue(MixpanelEventTracker, event, properties) unless Rails.env.test?
  end

  def build_and_queue_people_data(data = {})
    data["$token"] = @token
    data = people_data.merge(data)

    if !data.has_key?("$token")
      raise "Token is required"
    end

    Resque.enqueue(MixpanelPeopleData, data) unless Rails.env.test?
  end

  def current_user
    @current_user ||= Thread.current[:user]
  end

  private

  def user_properties
    if current_user
      {
        "distinct_id" => user_distinct_id(@current_user),
        "mp_name_tag" => @current_user.full_name
      }
    else
      {}
    end
  end

  def people_data
    if current_user
      {
        "$distinct_id" => user_distinct_id(@current_user)
      }
    else
      {}
    end
  end
end