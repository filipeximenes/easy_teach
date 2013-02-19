module MessageAuthorization

  def receiver
    @receiver ||= params[:messageable_type].classify.constantize.find(params[:messageable_id]) || not_found
  end

  def extract_receiver
    if defined? params[:response_to_messageable_group] and params[:response_to_messageable_group]
      @receiver ||= params[:messageable_group_type].classify.constantize.find(params[:messageable_group_id]) || not_found
    else
      @receiver ||= showing_message.sender
    end
  end

  def showing_message
    @showing_message ||= Message.find(params[:id])
  end

  def authorize_send_to
    # verifies if current_user can send message to receiver
    authorize = false

    if current_logged.class == Teacher
      if receiver.class == Classroom
        @classroom = current_logged.index.classrooms.find(receiver) || not_found
        authorize = true
      elsif receiver.class == EnrolledEmail
        @classroom = current_logged.index.classrooms.find(receiver.classroom) || not_found
        authorize = true
      elsif receiver.class == Teacher
        if receiver.index.slug == APP_CONFIG["application_name"]
          authorize = true
        end
      end
    end

    if !authorize
      not_found
    end
  end

  def authorize_visualization
    # verifies if current user can see the message
    authorize = false

    if current_logged == showing_message.sender or
      current_logged == showing_message.receiver
      authorize = true
    elsif current_logged.class == Teacher
      if showing_message.receiver.class == Classroom
        @classroom = current_logged.index.classrooms.find(showing_message.receiver) || not_found
        authorize = true
      end
    end

    if !authorize
      not_found
    end
  end

  def get_redirect_url
    if current_logged.class == Teacher
      dashboard_path
    else
      root_path
    end
  end
end