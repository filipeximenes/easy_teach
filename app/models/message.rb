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

class Message < ActiveRecord::Base
  attr_accessible :answered, :message, :sender, :receiver
  belongs_to :sender, :polymorphic => true
  belongs_to :receiver, :polymorphic => true

  validates :message, presence: true
end
