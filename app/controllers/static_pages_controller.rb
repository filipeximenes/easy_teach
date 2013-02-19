#encoding: utf-8

class StaticPagesController < ApplicationController

  def root
    flash.keep
    if indexable_signed_in?
      redirect_to indices_show_path(current_index)
    else
      redirect_to home_path
    end
  end

  def home
    @teacher = Teacher.new
    @teacher.build_index
    session[:invtf] = params[:invtf] if !params[:invtf].nil?
  end

  def referral
    
  end
end
