class EnrolledEmailsController < ApplicationController
  include UrlUtil::EnrolledEmailUrlUtil

  before_filter :authenticate_teacher!, except: [:new, :create]
  before_filter :load_and_authorize_from_enrolled_email_id!, except: [:new, :create]

  def new
    @enrolled_email = EnrolledEmail.new
  end

  def create
    @classroom = Classroom.find(params[:classroom_id]) || not_found
    @enrolled_email = @classroom.enrolled_emails.build(params[:enrolled_email])
    if @enrolled_email.save
      # flash[:success] = "Welcome to the Sample App!"
      redirect_to classroom_show_path(@classroom)
    else
      render 'new'
    end
  end

  def accept
    @enrolled_email.toggle(:confirmed)
    @enrolled_email.save
    redirect_to students_classroom_path(@classroom)
  end

  def edit
  end

  def update
    @enrolled_email = @classroom.enrolled_emails.find(params[:id])
    if @enrolled_email.update_attributes(params[:enrolled_email])
      # flash[:success] = "Welcome to the Sample App!"
      redirect_to classroom_show_path(@classroom)
    else
      render 'edit'
    end
  end

  def destroy
    @enrolled_email.destroy
    redirect_to classroom_show_path(@classroom)
  end
end
