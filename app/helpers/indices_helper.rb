module IndicesHelper
  def current_index
    if teacher_signed_in?
      current_teacher.index
    end
  end

  def current_indexable
    if teacher_signed_in?
      current_teacher
    end
  end

  def indexable_signed_in?
    !current_teacher.nil?
  end

  def current_indexable_path
    if indexable_signed_in?
      show_indexable_path(slug: current_index.slug)
    else
      root_path
    end
  end
end
