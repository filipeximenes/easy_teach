class ClassroomShowController < ApplicationController
  include ClassroomShowHelper

  before_filter :existing_index, only: [:classroom_page]
  before_filter :existing_classroom, only: [:classroom_page]


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
