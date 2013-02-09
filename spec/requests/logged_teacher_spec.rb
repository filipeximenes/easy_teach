require 'spec_helper'
require 'support/request_helpers'

include RequestHelpers

describe "Teacher" do

  subject { page }

  let(:teacher) { FactoryGirl.create(:teacher) }

  describe "loged in" do
    before { login_teacher teacher }

    describe "visiting edit path" do
      before { get edit_teacher_path }
      specify { response.should be_success }
    end

    describe "visiting root path" do
      before { get root_path }
      specify { response.should redirect_to(index_path(teacher.index))}
    end

    describe "visiting teacher invitation page" do
      before { get new_invited_teacher_path }
      specify { response.should be_success }
    end

    describe "visiting new classroom page" do
      before { get new_classroom_path }
      specify { response.should be_success }
    end

    describe "with owned classroom" do
      let(:classroom) { FactoryGirl.create(:classroom, index: teacher.index) }

      describe "visiting manager classroom page" do
        before { get classroom_show_path(classroom) }
        specify { response.should redirect_to(students_classroom_path(classroom)) }
      end

      describe "visiting classroom page" do
        before { get classroom_page_path(classroom.index.slug, classroom.slug) }
        specify { response.should be_success }
      end

      describe "visiting classroom edit page" do
        before { get edit_classroom_path(classroom) }
        specify { response.should be_success }
      end

      describe "visiting classroom students page" do
        before { get students_classroom_path(classroom) }
        specify { response.should be_success }
      end
    end

    describe "with not owned classroom" do
      let(:index2) { FactoryGirl.create(:index, slug: "outro_slug") }
      let(:teacher2) { FactoryGirl.create(:teacher, index: index2, email: "outro@email.com") }
      let(:classroom) { FactoryGirl.create(:classroom, index: teacher2.index) }

      describe "visiting manager classroom page" do
        before { get classroom_show_path(classroom) }
        specify { response.should_not be_success }
      end

      describe "visiting classroom page" do
        before { get classroom_page_path(classroom.index.slug, classroom.slug) }
        specify { response.should be_success }
      end

      describe "visiting classroom edit page" do
        before { get edit_classroom_path(classroom) }
        specify { response.should_not be_success }
      end

      describe "visiting classroom students page" do
        before { get students_classroom_path(classroom) }
        specify { response.should_not be_success }
      end
    end
  end
end