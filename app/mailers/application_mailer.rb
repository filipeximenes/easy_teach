class ApplicationMailer < ActionMailer::Base
  default from: "filipeximenes@gmail.com"

  def invite_teacher(hsh={})
    @sender = hsh[:from]
    @recipient = hsh[:to]
    mail(to: hsh[:to], 
          subject: t(:invite_teacher_subject)
          )
  end
end
