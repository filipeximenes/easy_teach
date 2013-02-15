#encoding: utf-8

module MessagesHelper
  @@show_via_classes = [EnrolledEmail]

  def get_message_sender_name(message)
    if message.sender == current_logged
      "Você"
    else
      if @@show_via_classes.include? message.sender.class
        extra_info = " (" + message.sender.classroom.name + ")"
      end
      message.sender.name + extra_info.to_s
    end
  end

  def get_message_receiver_name(message)
    if message.receiver == current_logged
      "Você"
    else
      if @@show_via_classes.include? message.receiver.class
        extra_info = " (" + message.receiver.classroom.name + ")"
      end
      message.receiver.name + extra_info.to_s
    end
  end
end
