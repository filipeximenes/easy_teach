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
#  referral_count         :integer          default(1)
#

require 'spec_helper'

describe Teacher do
  
  let(:teacher) { FactoryGirl.create(:teacher) }

  subject { teacher }

  it { should respond_to(:name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:index) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
end
