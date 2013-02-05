class InvitedTeachersController < ApplicationController
  before_filter :authenticate_teacher!

  def new
    @classroom_slug = params[:classroom_slug]
  end

  def create
    emails = params[:emails].delete(" ").split(",")

    emails.each { |email|
      invitation = current_teacher.invited_teachers.create(email: email)
    }
    if emails.length > 0
      # flash[:success] = "Welcome to the Sample App!"
    end
    if !params[:classroom_slug].nil? and !params[:classroom_slug].empty?
      redirect_to show_classroom_path(indexable_slug: current_index.slug,
                                classroom_slug: params[:classroom_slug])
    else
      redirect_to current_indexable_path
    end
  end
end
