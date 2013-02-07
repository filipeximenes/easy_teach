# == Schema Information
#
# Table name: invited_teachers
#
#  id         :integer          not null, primary key
#  teacher_id :integer
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class InvitedTeacher < ActiveRecord::Base
  attr_accessible :email
  belongs_to :teacher

  validates :email, presence: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :teacher_id, presence: true

  after_create :send_invitation_email

  private
    def send_invitation_email
      ApplicationMailer.invite_teacher(from: teacher, to: self.email).deliver
    end
end
