class CallParents
  @queue = :call_parents

  def self.perform
    Parent.with_unchecked_messages.each do |parent|
      call(parent)
    end
  end

  def self.call(parent)
    $twilio.account.calls.create(
      from: '+17132346203',
      to: parent.phone,
      url: callback_url,
      method: "GET",
      ifMachine: "Continue"
    )
  end

  def self.callback_url
    Rails.application.config.root_url + Rails.application.routes.url_helpers.phone_deliveries_path
  end
end