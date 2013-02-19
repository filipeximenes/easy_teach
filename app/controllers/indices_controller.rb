#encoding: utf-8

class IndicesController < ApplicationController

  before_filter :authenticate_teacher!

  def dashboard
  end

  def referral
  end
end
