#encoding: utf-8

class ClassroomShowController < ApplicationController
  include UrlUtil::FriendlyUrlUtil

  before_filter :load_context_from_classroom_slug, only: [:classroom_page]

  def classroom_page
  end
  
  def show
    @classroom = Classroom.find(params[:id]) || not_found
    flash.keep
    if @classroom.index == current_index
      redirect_to students_classroom_path(@classroom)
    else
      redirect_to classroom_page_path(@classroom.index.slug, @classroom.slug)
    end
  end
end
