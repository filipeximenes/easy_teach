# == Schema Information
#
# Table name: indices
#
#  id             :integer          not null, primary key
#  slug           :string(255)
#  indexable_id   :integer
#  indexable_type :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Index do
  
  let(:index_item) { FactoryGirl.create(:index) }

  subject { index_item }

  it { should respond_to(:slug) }
  it { should respond_to(:classrooms) }

  describe "with blank slug" do
    before { index_item.slug = "  " }
    it { should_not be_valid }
  end

  describe "with slug too long" do
    before { index_item.slug = "a" * 51 }
    it { should_not be_valid }
  end

  describe "should downcase slug before save" do
    let(:mixed_slug) { "DUndKDMS" }
    before do
      index_item.slug = mixed_slug
      index_item.save
    end

    its(:slug) { should == mixed_slug.downcase }
  end

  describe "should have unique index" do
    let(:another_index) { index_item.dup }

    subject { another_index }

    it { should_not be_valid }

    describe "and should be case insensitive" do
      before { another_index.slug = index_item.slug.upcase }

      it { should_not be_valid }
    end
  end
end
