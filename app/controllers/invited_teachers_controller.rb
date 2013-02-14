class InvitedTeachersController < ApplicationController
  before_filter :authenticate_teacher!

  def new
  end

  def create
    emails = params[:emails].delete(" ").split(",")

    emails.each { |email|
      invitation = current_teacher.invited_teachers.create(email: email)
    }
    if emails.length > 0
      # flash[:success] = "Welcome to the Sample App!"
    end
    if !teacher_session[:created_classroom].nil?
      classroom_id = teacher_session[:created_classroom]
      teacher_session.delete :created_classroom
      redirect_to classroom_show_path(Classroom.find(classroom_id))
    else
      redirect_to current_index
    end
  end
end
