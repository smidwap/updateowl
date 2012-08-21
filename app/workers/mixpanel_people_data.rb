class MixpanelPeopleData
  @queue = :mixpanel_people_data

  def self.perform(data)
    data = Base64.strict_encode64(JSON.generate(data))
    request = "http://api.mixpanel.com/engage/?data=#{data}"

    `curl -s '#{request}' &`
  end
end