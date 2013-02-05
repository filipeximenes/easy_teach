require 'spec_helper'

describe "static_pages/home.html.erb" do
  let(:indexable) { FactoryGirl.create(:teacher) }

  subject { page }

  describe "should show indexable page" do
    before { get show_indexable_path(slug: indexable.index.slug) }
    specify { response.should_not redirect_to('/404.html') }
  end

  describe "should show 404 for not available profile" do
    before { get show_indexable_path(slug: "othe_slug") }
    specify { response.should redirect_to('/404.html') }
  end
end
