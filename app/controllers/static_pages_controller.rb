class StaticPagesController < ApplicationController

  def root
    if indexable_signed_in?
      redirect_to current_index
    else
      redirect_to home_path
    end
  end

  def home
    @teacher = Teacher.new
    @teacher.build_index
    @referral = params[:invtf] if !params[:invtf].nil?
  end
end
