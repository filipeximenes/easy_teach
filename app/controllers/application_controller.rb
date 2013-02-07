class ApplicationController < ActionController::Base
  protect_from_forgery
  include IndicesHelper

  def not_found
    raise ActiveRecord::RecordNotFound.new('Not Found')
  end
end
