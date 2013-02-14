# == Schema Information
#
# Table name: messages
#
#  id            :integer          not null, primary key
#  sender_id     :integer
#  sender_type   :string(255)
#  receiver_id   :integer
#  receiver_type :string(255)
#  message       :text
#  answered      :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Message do

end
