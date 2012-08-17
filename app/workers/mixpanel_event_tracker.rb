class MixpanelEventTracker
  @queue = :mixpanel_event_tracker

  def self.perform(event, properties)
    params = {"event" => event, "properties" => properties}
    data = Base64.strict_encode64(JSON.generate(params))
    request = "http://api.mixpanel.com/track/?data=#{data}"

    `curl -s '#{request}' &`
  end
end