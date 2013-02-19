# == Schema Information
#
# Table name: enrolled_emails
#
#  id           :integer          not null, primary key
#  classroom_id :integer
#  email        :string(255)
#  name         :string(255)
#  confirmed    :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class EnrolledEmail < ActiveRecord::Base
  attr_accessible :email, :name, :confirmed
  belongs_to :classroom
  
  has_many :sent_messages, as: :sender, class_name: "Message", dependent: :destroy
  has_many :received_messages, as: :receiver, class_name: "Message", dependent: :destroy

  validates_uniqueness_of :email, scope: [:classroom_id],
                            case_sensitive: false
  validates :email, presence: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
end
