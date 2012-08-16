class MessageMailer < ActionMailer::Base
  def notification(delivery)
    @delivery = delivery

    mail \
      to: @delivery.parent.email,
      from: "#{@delivery.message.student.grade_level.school.name} <no-reply@updateowl.com>",
      subject: "New Update for #{@delivery.student.first_name}"
  end
end