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

require 'spec_helper'

describe InvitedTeacher do
  pending "add some examples to (or delete) #{__FILE__}"
end
