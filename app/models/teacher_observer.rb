class TeacherObserver < ActiveRecord::Observer
  include AdminTeacher

  observe :teacher

  def after_create(teacher)
    message = Message.create(sender: admin_teacher, receiver: teacher, message: I18n.t(:invite_other_teacher_to_earn))
    message = Message.create(sender: admin_teacher, receiver: teacher, message: I18n.t(:how_to_create_a_classroom))
    message = Message.create(sender: admin_teacher, receiver: teacher, message: I18n.t(:wellcome_message))
  end
end
