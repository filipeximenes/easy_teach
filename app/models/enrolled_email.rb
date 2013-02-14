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

  validates_uniqueness_of :email, scope: [:classroom_id],
                            presence:   true,
                            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                            case_sensitive: false
end
