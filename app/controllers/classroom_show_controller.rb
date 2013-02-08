class ClassroomShowController < ApplicationController
  include ClassroomShowHelper

  before_filter :existing_index, only: [:classroom_page]
  before_filter :existing_classroom, only: [:classroom_page]

  def show
    @classroom = Classroom.find(params[:id]) || not_found
    if @classroom.index == current_index
      redirect_to students_classroom_path(@classroom)
    else
      flash.keep
      redirect_to classroom_page_path(@classroom.index.slug, @classroom.slug)
    end
  end

  def classroom_page
  end
end
