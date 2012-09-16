class DeliverySetup
  @queue = :delivery_setup

  def self.perform(message_id)
    message = Message.find(message_id)

    message.students.each do |student|
      student.parents.each do |parent|
        delivery = new_delivery_for_student_and_parent(student, parent)
        delivery.message = message
        delivery.save!
      end
    end
  end

  def self.new_delivery_for_student_and_parent(student, parent)
    delivery = Delivery.new
    delivery.student = student
    delivery.parent = parent
    delivery
  end
end