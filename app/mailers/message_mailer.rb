class MessageMailer < ActionMailer::Base
  def notification(message, parent)
    @message = message
    @parent = parent

    mail(to: @parent.email, from: "#{message.student.grade_level.school.name} <no-reply@updatemeapp.com>")
  end
end