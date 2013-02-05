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

class Index < ActiveRecord::Base
  attr_accessible :slug
  belongs_to :indexable, :polymorphic => true
  has_many :classrooms

  validates :slug, presence: true, 
                    length: { maximum: 50 },
                    uniqueness: { case_sensitive: false },
                    format:     { with: /\A[a-zA-Z][a-zA-Z0-9_-]{3,}\Z/ }

  before_save { self.slug = self.slug.downcase }
end
