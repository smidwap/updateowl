class CallParents
  @queue = :call_parents

  def self.perform
    Parent.with_unchecked_messages.prefers_phone.each do |parent|
      call(parent)
    end
  end

  def self.call(parent)
    $twilio.account.calls.create(
      from: '+17132346203',
      to: parent.phone,
      url: callback_url(parent),
      method: "GET",
      ifMachine: "Continue"
    )
  end

  def self.callback_url(parent)
    Rails.application.config.root_url + Rails.application.routes.url_helpers.phone_parent_deliveries_path(parent)
  end
end