class CallParents
  @queue = :call_parents

  def self.perform
    Parent.with_unchecked_messages.prefers_phone.each do |parent|
      call(parent)
    end
  end

  def self.call(parent)
    $twilio.account.calls.create(
      from: from_phone,
      to: parent.phone,
      url: callback_url(parent),
      method: "GET",
      ifMachine: "Hangup"
    )
  end

  def self.callback_url(parent)
    Rails.application.config.root_url + Rails.application.routes.url_helpers.parental_phone_parent_deliveries_path(parent)
  end

  def self.from_phone
    Rails.env == "production" ? '+17132346203' : '+13174947897'
  end
end