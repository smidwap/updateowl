class MixpanelEventBuilder
  attr_accessor :current_user, :token

  def initialize(token)
    @token = token
  end

  # A simple function for asynchronously logging to the mixpanel.com API.
  # This function requires `curl`.
  #
  # event: The overall event/category you would like to log this data under
  # properties: A hash of key-value pairs that describe the event. Must include 
  # the Mixpanel API token as 'token'
  #
  # See http://mixpanel.com/api/ for further detail.
  def build_and_queue_event(event, properties={})
    properties["token"] = @token
    properties = user_properties.merge(properties)

    if !properties.has_key?("token")
      raise "Token is required"
    end

    Resque.enqueue(MixpanelEventTracker, event, properties) unless Rails.env.test?
  end

  private

  def user_properties
    current_user = Thread.current[:user]
    if current_user
      {
        "distinct_id" => current_user.id,
        "mp_name_tag" => current_user.full_name
      }
    else
      {}
    end
  end
end