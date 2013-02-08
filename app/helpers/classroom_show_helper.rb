module ClassroomShowHelper

  def existing_classroom
    page_classroom
  end

  def page_classroom
    @page_classroom ||= page_index.classrooms.find_by_slug(params[:classroom_slug].downcase) || not_found
  end
end
