class ClassroomsController < ApplicationController
  include ClassroomsHelper

  before_filter :existing_index, only: [:classroom_page]
  before_filter :existing_classroom, only: [:classroom_page]
  before_filter :authenticate_teacher!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :allow_classroom_edition?, only: [:edit, :update, :destroy]

  def show
    @classroom = Classroom.find(params[:id]) || not_found
    redirect_to classroom_page_path @classroom.index.slug, @classroom.slug 
  end

  def classroom_page
    @enrolled_email = EnrolledEmail.new
  end

  def new
    @classroom = Classroom.new
  end

  def edit
    @classroom = editable_classroom
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
    @classroom = editable_classroom
    if @classroom.update_attributes(params[:classroom])
      # flash[:success] = "Profile updated"
      invite_students
      redirect_to @classroom
    else
      render 'edit'
    end
  end

  def destroy
    editable_classroom.destroy
  end

  private
    def after_classroom_creation_path
      if current_index.classrooms.count == 1
        new_invited_teacher_path
      else
        @classroom
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
