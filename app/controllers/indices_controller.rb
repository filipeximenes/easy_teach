class IndicesController < ApplicationController

  before_filter :authenticate_teacher!

  def dashboard
  end
end
