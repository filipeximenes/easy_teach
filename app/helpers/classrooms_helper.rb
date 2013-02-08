module ClassroomsHelper
  def allow_classroom_edition?
    page_classroom.index == current_index
  end

  def page_classroom
    @page_classroom ||= Classroom.find(params[:id]) || not_found
  end
end
