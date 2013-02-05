class TeacherMailer < ActionMailer::Base
  default from: "filipeximenes@gmail.com"

  def invitation(hsh={})
    @sender = hsh[:from]
    @recipient = hsh[:to]
    mail(to: "filipeximenes@gmail.com", 
          subject: "teste"
          )
  end
end
