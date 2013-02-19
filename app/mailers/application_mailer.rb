class ApplicationMailer < ActionMailer::Base
  default from: APP_CONFIG["application_default_email"]

  def invite_teacher(hsh={})
    @sender = hsh[:from]
    @recipient = hsh[:to]
    mail(to: hsh[:to], 
          subject: t(:invite_teacher_subject)
          )
  end

  def deliver_message_through_email(hsh={})
    @message = hsh[:message]
    @previous_message_text = hsh[:previous_message_text]

    mail(to: hsh[:to_email],
        subject: t(:new_message_subject)
      )
  end
end
