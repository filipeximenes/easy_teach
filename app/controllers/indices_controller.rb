class IndicesController < ApplicationController
  before_filter :existing_index,   only: [:indexable_page]

  def show
    @index = Index.find(params[:id]) || not_found
    redirect_to indexable_page_path @index.slug
  end

  def indexable_page
  end
end
