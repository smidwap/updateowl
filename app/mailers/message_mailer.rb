class MessageMailer < ActionMailer::Base
  def notification(delivery)
    @delivery = delivery

    I18n.locale = delivery.parent.locale

    mail \
      to: @delivery.parent.email,
      from: "#{@delivery.message.school.name} <no-reply@updateowl.com>",
      subject: t('parental.email.subject', student: @delivery.student.first_name, time: @delivery.created_at.strftime('%B %e at %l:%M%P'))
  end
end