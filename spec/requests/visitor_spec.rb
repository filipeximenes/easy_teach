require 'spec_helper'

describe "Visitor" do

  subject { page }

  let(:indexable) { FactoryGirl.create(:teacher) }
  let(:classroom) { FactoryGirl.create(:classroom, index: indexable.index) }

  describe "not loged in" do

    describe "visiting home page" do
      before{ get home_path }
      specify { response.should be_success }
    end

    describe "visiting existing classroom page" do
      before { get classroom_page_path(classroom.index.slug, classroom.slug) }
      specify { response.should be_success }
    end

    describe "visiting teacher invitation page" do
      before { get new_invited_teacher_path }
      specify { response.should_not be_success }
    end

    describe "visiting new classroom page" do
      before { get new_classroom_path }
      specify { response.should_not be_success }
    end

    describe "visiting edit classroom page" do
      before { get edit_classroom_path(classroom) }
      specify { response.should_not be_success }
    end
  end
end
