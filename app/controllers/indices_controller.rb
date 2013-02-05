class IndicesController < ApplicationController
  def show
    if indexable_signed_in? and current_index.slug == params[:slug]
      @indexable = current_indexable
    else
      @indexable = Index.find_by_slug(params[:slug])
    end
    if !@indexable.nil?
      @classrooms = @indexable.classrooms
    else
      redirect_to '/404.html'
    end
  end
end
