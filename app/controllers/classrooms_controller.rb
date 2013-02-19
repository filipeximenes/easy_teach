class ClassroomsController < ApplicationController
  include UrlUtil::ClassroomUrlUtil

  before_filter :authenticate_teacher!
  before_filter :load_and_authorize_from_classroom_id!, except: [:new, :create]

  def students
  end

  def messages
  end

  def new
    if current_indexable.free_class_counter <= current_index.classrooms.count
      flash[:success] = "Você atingiu o seu limite de turmas. Convide outros professores para criar mais turmas."
      redirect_to referral_path
    end
  end

  def edit
  end

  def create
    @classroom = current_index.classrooms.build(params[:classroom])
    if @classroom.save
      flash[:success] = "Turma criada!"
      invite_students
      redirect_to after_classroom_creation_path
    else
      render 'new'
    end
  end

  def update
    if @classroom.update_attributes(params[:classroom])
      flash[:success] = "Dados atualizados"
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
        teacher_session[:created_classroom] = @classroom.id
        referral_path
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
