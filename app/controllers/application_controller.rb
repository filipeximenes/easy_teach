#encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_index, :current_indexable, :current_logged

  def not_found
    raise ActiveRecord::RecordNotFound.new('Not Found')
  end

  def current_indexable
    @current_indexable ||= current_teacher
  end

  def current_index
    if indexable_signed_in?
      @current_index ||= current_indexable.index
    end
  end

  def indexable_signed_in?
    teacher_signed_in?
  end

  def current_logged
    current_teacher
  end
end
