class ClassroomsController < ApplicationController
  include ClassroomsHelper

  include UrlUtil::ClassroomUrlUtil

  before_filter :authenticate_teacher!
  before_filter :load_context_from_classroom_id, only: [:edit, :update, :destroy, :students,
                                          :messages, :show_enrolled_email_message,
                                          :answer_enrolled_email_message,]
  before_filter :classroom_manager?, only: [:edit, :update, :destroy, :students,
                                          :messages, :show_enrolled_email_message,
                                          :answer_enrolled_email_message,]

  def students
  end

  def messages
  end

  def show_enrolled_email_message
    @message = Message.find(params[:message_id])
    if @message.sender.classroom != @classroom
      redirect_to root_path
    end
  end

  def answer_enrolled_email_message
    @message = Message.find(params[:message_id])
    if @message.sender.classroom == @classroom
      if params[:answer_to_all]
        new_message = Message.new(sender: current_teacher, receiver: @classroom, message: params[:response])
        # agrupar os email que vai receber
      else
        enrolled_email = @classroom.enrolled_emails.find(params[:enrolled_email_id])
        if enrolled_email
          new_message = Message.new(sender: current_teacher, receiver: enrolled_email, message: params[:response])
          # pegar o email do receiver
        end
      end
      if new_message.save
        flash[:success] = t(:successfully_sent_message)
      else
        flash[:error] = t(:error_sending_message)
      end
    end
    redirect_to messages_classroom_path
  end

  def new
  end

  def edit
  end

  def create
    @classroom = current_index.classrooms.build(params[:classroom])
    if @classroom.save
      # flash[:success] = "Welcome to the Sample App!"
      teacher_session[:created_classroom] = @classroom.id
      invite_students
      redirect_to after_classroom_creation_path
    else
      render 'new'
    end
  end

  def update
    if @classroom.update_attributes(params[:classroom])
      # flash[:success] = "Profile updated"
      invite_students
      redirect_to classroom_show_path(@classroom)
    else
      render 'edit'
    end
  end

  def destroy
    @classroom.destroy
  end

  private
    def after_classroom_creation_path
      if current_index.classrooms.count == 1
        new_invited_teacher_path
      else
        students_classroom_path(@classroom)
      end
    end

    def invite_students
      emails = params[:student_email_list].delete(" ").split(",")
      emails.each { |email|
        new_classroom = @classroom.enrolled_emails.create(email: email)
        new_classroom.confirmed = true
        new_classroom.save
      }
    end
end
