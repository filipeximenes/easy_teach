class TeachersController < ApplicationController
  before_filter :authenticate_teacher!, only: [:edit, :update]

  def edit
  end

  def create
    @teacher = Teacher.new(params[:teacher])
    if @teacher.save
      sign_in @teacher
      # flash[:success] = "Welcome to the Sample App!"
      redirect_to new_classroom_path
    else
      render 'static_pages/home'
    end
  end

  def update
    if current_teacher.update_attributes(params[:teacher])
      # flash[:success] = "Profile updated"
      redirect_to current_indexable_path
    else
      render 'edit'
    end
  end
end
