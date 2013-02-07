module IndicesHelper

  def existing_index
    page_indexable
    page_index
  end

  def page_indexable
    @page_indexable ||= page_index.indexable
  end

  def page_index
    if indexable_signed_in? and current_index.slug == params[:indexable_slug].downcase
      @page_index ||= current_index
    else
      @page_index ||= Index.find_by_slug(params[:indexable_slug].downcase) || not_found
    end
  end

  def page_owned_by_current_indexable?
    indexable_signed_in? and current_index.slug == params[:indexable_slug].downcase
  end

  def current_index
    if indexable_signed_in?
      @current_index ||= current_indexable.index
    end
  end

  def indexable_signed_in?
    teacher_signed_in?
  end

  def current_indexable
    @current_indexable ||= current_teacher
  end
end
