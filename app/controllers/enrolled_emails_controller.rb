class EnrolledEmailsController < ApplicationController
  include ClassroomsHelper
  include EnrolledEmailsHelper

  before_filter :existing_index, only: [:new, :creates, :update]
  before_filter :existing_classroom, only: [:new, :create, :update]
  before_filter :allow_enrolled_email_edition?, only: [:edit, :destroy]

  def new
    @enrolled_email = EnrolledEmail.new
  end

  def edit
  end

  def create
    @enrolled_email = page_classroom.enrolled_emails.build(params[:enrolled_email])
    if @enrolled_email.save
      # flash[:success] = "Welcome to the Sample App!"
      redirect_to page_classroom
    else
      render 'new'
    end
  end

  def update
    @enrolled_email = page_classroom.enrolled_emails.find(params[:id])
    if @enrolled_email.update_attributes(params[:enrolled_email])
      # flash[:success] = "Welcome to the Sample App!"
      redirect_to page_classroom
    else
      render 'edit'
    end
  end

  def destroy
    editable_enrolled_email.destroy
    redirect_to classroom_from_editable_enrolled_email
  end
end
