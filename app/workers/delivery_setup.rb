class DeliverySetup
  @queue = :delivery_setup

  def self.perform(message_id)
    message = Message.find(message_id)

    message.recipients.each do |parent|
      parent.deliveries.create(message: message)
    end
  end
end