module MessageAuthorization
  def authorize_message_to
    authorize = false

    if current_logged.class == Teacher
      if receiver.class == EnrolledEmail
        @classroom = current_logged.index.classrooms.find(receiver.classroom) || not_found
        authorize = true
      end
    end

    if !authorize
      redirect_to '/'
    end
  end

  def receiver
    @receiver ||= params[:messageable_type].classify.constantize.find(params[:messageable_id]) || not_found
  end

  def authorize_new_response_to
    authorize = false

    if current_logged.class == Teacher
      if showing_message.sender.class == EnrolledEmail
        @classroom = current_logged.index.classrooms.find(showing_message.sender.classroom) || not_found
        authorize = true
      end
    end

    if !authorize
      redirect_to '/'
    end
  end

  def showing_message
    @showing_message ||= Message.find(params[:id])
  end

  def authorize_create_response_to
    authorize = false

    authorize_new_response_to

    if messageable.class == Classroom
      @classroom = current_logged.index.classrooms.find(messageable) || not_found
      authorize = true
    elsif messageable.class == EnrolledEmail
      @classroom = current_logged.index.classrooms.find(messageable.classroom) || not_found
      authorize = true
    end 

    if !authorize
      redirect_to '/'
    end
  end

  def messageable
    if defined? params[:response_to_messageable_group] and params[:response_to_messageable_group]
      @messageable ||= params[:messageable_group_type].classify.constantize.find(params[:messageable_group_id]) || not_found
    else
      @messageable ||= @showing_message.sender
    end
  end
end