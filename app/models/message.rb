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
  attr_accessible :answered, :message, :sender, :receiver, :previous_message_text
  attr_accessor :previous_message_text
  belongs_to :sender, :polymorphic => true
  belongs_to :receiver, :polymorphic => true

  validates :message, presence: true

  after_create :send_email_message

  private
    def send_email_message
      if receiver.class == Classroom
        receiver.enrolled_emails.each{ |item|
          ApplicationMailer.deliver_message_through_email(message: self,
            to_email: item.email).deliver
        }
      else
        ApplicationMailer.deliver_message_through_email(message: self, to_email: receiver.email,
          previous_message_text: previous_message_text).deliver
      end
    end
end
