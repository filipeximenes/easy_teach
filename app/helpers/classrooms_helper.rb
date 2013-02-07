module ClassroomsHelper

  def existing_classroom
    page_classroom
  end

  def page_classroom
    @page_classroom ||= page_index.classrooms.find_by_slug(params[:classroom_slug].downcase) || not_found
  end

  def editable_classroom
    @editable_classroom ||= Classroom.find(params[:id]) || not_found
  end

  def allow_classroom_edition?
    editable_classroom.index == current_index
  end
end
