class SupportMailer < ActionMailer::Base
  SUPPORT_EMAILS = ['matt@updateowl.com', 'brian@updateowl.com']

  def support_request(args)
    @requestor = args[:requestor]
    @request = args[:request]

    mail \
      to: SUPPORT_EMAILS,
      from: 'no-reply@updateowl.com',
      subject: "[UpdateOwl Support] New Request from #{@requestor.full_name}"
  end
end