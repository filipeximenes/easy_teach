module ClassroomsHelper
  def classroom_manager?
    if !(@classroom.index == current_index)
      redirect_to root_path
    end
  end
end
