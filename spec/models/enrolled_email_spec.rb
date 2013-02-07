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

require 'spec_helper'

describe EnrolledEmail do
  
end
