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
  belongs_to :indexable, polymorphic: true, dependent: :destroy
  has_many :classrooms, dependent: :destroy

  validates :slug, presence: true, 
                    length: { maximum: 50, minimun: 3 },
                    uniqueness: { case_sensitive: false },
                    format:     { with: /\A[a-zA-Z][a-zA-Z0-9_-]+\Z/ }

  before_save { self.slug = self.slug.downcase }
end
