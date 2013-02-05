class ClassroomsController < ApplicationController
  before_filter :authenticate_teacher!, only: [:new, :edit, :update, :destroy, :create]

  def show
    @indexable = Index.find_by_slug(params[:indexable_slug]).indexable
    @classroom = @indexable.classrooms.find_by_slug(params[:classroom_slug])
  end

  def new
    @classroom = Classroom.new
  end

  def edit
  end

  def create
    @classroom = current_index.classrooms.build(params[:classroom])
    if @classroom.save
      # flash[:success] = "Welcome to the Sample App!"
      redirect_to after_classroom_creation_path
    else
      render 'new'
    end
  end

  def update
    if current_teacher.update_attributes(params[:teacher])
      # flash[:success] = "Profile updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private
    def after_classroom_creation_path
      if current_index.classrooms.count == 1
        new_invited_teacher_path(:classroom_slug => @classroom.slug)
      else
        current_indexable_path
      end
    end
end
