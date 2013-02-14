class IndicesController < ApplicationController

  before_filter :authenticate_teacher!

  def dashboard
    @index = current_index
    @indexable = current_indexable
  end
end
