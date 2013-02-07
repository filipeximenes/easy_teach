# == Schema Information
#
# Table name: teachers
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  last_name              :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  free_class_counter     :integer          default(1)
#  referral_count         :integer          default(0)
#

# Include default devise modules. Others available are:
# :token_authenticatable,
# :lockable, :timeoutable and :omniauthable

class Teacher < ActiveRecord::Base
  @@REFERRALS_TO_FREE_CLASSROOM = 5

  devise :database_authenticatable, :recoverable, :confirmable,
        :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, 
                  :remember_me, :last_name, :name, :index_attributes
  has_one :index, :as => :indexable, :dependent => :destroy
  has_many :invited_teachers
  accepts_nested_attributes_for :index

  validates :name, presence: true
  validates :last_name, presence: true
  validates :index, presence: true
  validates :free_class_counter, :inclusion => 1..5

  def classrooms
    self.index.classrooms
  end

  def full_name
    self.name + " " + self.last_name
  end

  def referral_sinup
    self.referral_count += 1
    if (self.referral_count == @@REFERRALS_TO_FREE_CLASSROOM \
      && self.free_class_counter < 5)
      self.free_class_counter += 1
      self.referral_count = 0
    end
    self.save
  end
end