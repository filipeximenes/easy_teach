module MessageAuthorization
  def authorize_message_to
    # verifies if current_user can see and send message to receiver
    authorize = false

    if current_logged.class == Teacher
      if receiver.class == EnrolledEmail
        @classroom = current_logged.index.classrooms.find(receiver.classroom) || not_found
        authorize = true
      elsif receiver.class == Classroom
        @clasroom = current_logged.index.classrooms.find(receiver) || not_found
        authorize = true
      end
    end

    if !authorize
      not_found
    end
  end

  def receiver
    @receiver ||= params[:messageable_type].classify.constantize.find(params[:messageable_id]) || not_found
  end

  def authorize_visualization
    # verifies if current user can see the message
    authorize = false

    if current_logged.class == Teacher
      if showing_message.receiver == current_logged
        authorize = true
      elsif showing_message.receiver.class == Classroom
        @classroom = current_logged.index.classrooms.find(showing_message.receiver) || not_found
        authorize = true
      elsif showing_message.receiver.class == EnrolledEmail
        @classroom = current_logged.index.classrooms.find(showing_message.receiver.classroom) || not_found
        authorize = true
      end
    end

    if !authorize
      not_found
    end
  end

  def showing_message
    @showing_message ||= Message.find(params[:id])
  end

  def authorize_create_response_to
    # verifies if current_user can send message to messageable
    authorize = false

    authorize_visualization

    if messageable.class == Classroom
      @classroom = current_logged.index.classrooms.find(messageable) || not_found
      authorize = true
    elsif messageable.class == EnrolledEmail
      @classroom = current_logged.index.classrooms.find(messageable.classroom) || not_found
      authorize = true
    end 

    if !authorize
      not_found
    end
  end

  def messageable
    if defined? params[:response_to_messageable_group] and params[:response_to_messageable_group]
      @messageable ||= params[:messageable_group_type].classify.constantize.find(params[:messageable_group_id]) || not_found
    else
      @messageable ||= @showing_message.sender
    end
  end

  def get_redirect_url
    if current_logged.class == Teacher
      if defined? @classroom and @classroom
        messages_classroom_path(@classroom)
      else
        dashboard_indices_path
      end
    else
      root_path
    end
  end
end