require 'spec_helper'

describe "static_pages/home.html.erb" do
  let(:indexable) { FactoryGirl.create(:teacher) }

  subject { page }
end
