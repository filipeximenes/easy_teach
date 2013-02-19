class TeachersController < ApplicationController
  
  before_filter :authenticate_teacher!, except: [:create]

  def create
    @teacher = Teacher.new(params[:teacher])
    if @teacher.save
      sign_in @teacher
      # flash[:success] = "Welcome to the Sample App!"
      process_referral
      redirect_to new_classroom_path
    else
      render 'static_pages/home'
    end
  end

  def edit
    @teacher = current_teacher
  end

  def update
    @teacher = current_teacher
    if @teacher.update_with_password(params[:teacher])
      sign_in(@teacher, :bypass => true)
      flash[:success] = "Dados atualizados"
      redirect_to @teacher.index
    else
      render 'edit'
    end
  end

  private
    def process_referral
      if !session[:invtf].nil?
        referral_from = Teacher.find(session[:invtf])
        if referral_from
          session.delete :invtf
          referral_from.referral_sinup
        end
      end
    end
end
