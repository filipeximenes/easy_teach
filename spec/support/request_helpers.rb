require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

module RequestHelpers 
  def login_teacher(teacher)    
    login_as teacher, scope: :teacher
  end
end