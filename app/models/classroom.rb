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

class Classroom < ActiveRecord::Base
  attr_accessible :name, :slug

  belongs_to :index
  has_one :teacher, through: :index, source: :indexable, source_type: Teacher
  has_many :enrolled_emails
  has_many :messages, as: :receiver, class_name: "Message", 
            order: "created_at DESC"

  validates_uniqueness_of :slug, scope: [:index_id],
                                  case_sensitive: false
  validates :slug, presence: true, 
                    length: { maximum: 50 },
                    format:     { with: /\A[a-zA-Z][a-zA-Z0-9_-]{3,}\Z/ }
  validates :name, presence: true

  def received_messages
    Message.joins("JOIN enrolled_emails on sender_id = enrolled_emails.id")
            .where("sender_type = 'EnrolledEmail' AND enrolled_emails.classroom_id = ?", self.id)
            .order("created_at DESC")
  end

  def sent_messages
    self.messages
  end

  before_save { self.slug = self.slug.downcase }

  def owner
    if self.teacher
      return self.teacher
    else
      return nil
    end
  end
end
