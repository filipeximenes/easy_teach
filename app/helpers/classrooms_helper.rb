module ClassroomsHelper



  def allow_classroom_edition?
    if !(page_classroom.index == current_index)
      redirect_to root_path
    end
  end

  def page_classroom
    @page_classroom ||= Classroom.find(params[:id]) || not_found
  end
end
