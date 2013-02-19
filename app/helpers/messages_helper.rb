#encoding: utf-8

module MessagesHelper
  @@show_via_classes = [EnrolledEmail]

  def get_message_sender_name(message)
    if message.sender == current_logged
      "mim"
    else
      if @@show_via_classes.include? message.sender.class
        extra_info = " (" + message.sender.classroom.name + ")"
      end
      message.sender.name.to_s + extra_info.to_s
    end
  end

  def get_message_receiver_name(message)
    if message.receiver == current_logged
      "mim"
    else
      if @@show_via_classes.include? message.receiver.class
        extra_info = " (" + message.receiver.classroom.name + ")"
      end
      message.receiver.name.to_s + extra_info.to_s
    end
  end

  def link_to_message(message)
    if message.sender == current_logged 
      # or 
      # (message.sender.class == Teacher and message.sender.index.slug == APP_CONFIG["application_name"])
      message_path(message)
    else
      response_to_message_path(message)
    end
  end
end
