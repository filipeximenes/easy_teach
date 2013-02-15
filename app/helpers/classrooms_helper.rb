module ClassroomsHelper
  def messages_to_show
    if params[:show] == "sent_messages"
      @classroom.sent_messages
    else
      @classroom.received_messages
    end
  end

  def link_to_message(message)
    if message.sender == current_logged
      message_path(message)
    else
      response_to_message_path(message)
    end
  end
end
