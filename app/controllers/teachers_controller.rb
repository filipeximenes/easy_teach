class TeachersController < ApplicationController
  before_filter :authenticate_teacher!, only: [:edit, :update]

  def edit
    @teacher = current_teacher
  end

  def create
    @teacher = Teacher.new(params[:teacher])
    if @teacher.save
      sign_in @teacher
      # flash[:success] = "Welcome to the Sample App!"
      process_referral
      redirect_to new_classroom_manage_path
    else
      render 'static_pages/home'
    end
  end

  def update
    @teacher = current_teacher
    if @teacher.update_attributes(params[:teacher])
      sign_in(@teacher, :bypass => true)
      # flash[:success] = "Profile updated"
      redirect_to @teacher.index
    else
      render 'edit'
    end
  end

  private
    def process_referral
      if !params[:invtf].nil?
        logger.info("ali")
        referral_from = Teacher.find(params[:invtf])
        logger.info(params[:invtf])
        if referral_from
          logger.info("aqui")
          referral_from.referral_sinup
        end
      end
    end
end
