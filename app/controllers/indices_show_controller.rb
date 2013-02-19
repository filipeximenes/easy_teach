#encoding: utf-8

class IndicesShowController < ApplicationController
  include UrlUtil::FriendlyUrlUtil

  before_filter :load_context_from_indexable_slug, only: [:indexable_page]

  def indexable_page
  end

  def show
    @index = Index.find(params[:id]) || not_found
    flash.keep
    if @index == current_index
      redirect_to dashboard_path
    else
      redirect_to indexable_page_path(@index.slug)
    end
  end
end
