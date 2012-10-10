class DeliverySetup
  @queue = :delivery_setup

  def self.perform(student_message_id)
    StudentMessage.find(student_message_id).create_deliveries
  end
end