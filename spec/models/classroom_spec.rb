# == Schema Information
#
# Table name: classrooms
#
#  id         :integer          not null, primary key
#  index_id   :integer
#  name       :string(255)
#  slug       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Classroom do
  let(:classroom) { FactoryGirl.create(:classroom) }

  subject { classroom }

  it { should respond_to(:slug) }    
  it { should respond_to(:name) }    
  it { should respond_to(:index) }    
  it { should respond_to(:teacher) }
  it { should respond_to(:owner) }


  describe "with blank slug" do
    before { classroom.slug = "  " }
    it { should_not be_valid }
  end

  describe "with slug too long" do
    before { classroom.slug = "a" * 51 }
    it { should_not be_valid }
  end

  describe "should downcase slug before save" do
    let(:mixed_slug) { "DUndKDMS" }
    before do
      classroom.slug = mixed_slug
      classroom.save
    end

    its(:slug) { should == mixed_slug.downcase }
  end

  describe "should have unique slug for one indexable" do
    let(:another_classroom) { classroom.dup }

    subject { another_classroom }

    it { should_not be_valid }

    describe "and accep different ones" do
      before { another_classroom.slug = "different_slug" }
      it { should be_valid }
    end

    describe "and should be case insensitive" do
      before { another_classroom.slug = classroom.slug.upcase }

      it { should_not be_valid }
    end
  end

  describe "should accep same slug accross different indexables" do
    let(:index) { FactoryGirl.create(:index) }
    let(:another_classroom) { FactoryGirl.create(:classroom, index: index) }

    subject { another_classroom }

    it { should be_valid }
  end
end
