class MessagesController < ApplicationController

  def new_message_to
    @receiver = params[:messageable_type].classify.constantize.find(params[:messageable_id]) || not_found
    @message = Message.new
  end

  def create_message_to
    @receiver = params[:messageable_type].classify.constantize.find(params[:messageable_id]) || not_found
    @message = Message.new(sender: current_logged, receiver: @receiver, message: params[:message])
    if @message.save
      flash[:success] = t(:successfully_sent_message)
      redirect_to '/'
    else
      render 'new_message_to'
    end
  end

  def create_message_from_enrolled_email
    @classroom = Classroom.find(params[:classroom_id])
    if !@classroom.nil?
      @enrolled_email = @classroom.enrolled_emails.find_by_email(params[:email].downcase)
      if !@enrolled_email.nil?
        message = Message.create(sender: @enrolled_email, message: params[:message])
        flash[:success] = t(:successfully_sent_message)
        redirect_to classroom_show_path(@classroom) and return
      else
        flash.now[:error] = t(:enroled_email_not_found)
      end
    end
    @index = @classroom.index
    @indexable = @index.indexable
    render "classroom_show/classroom_page"
  end

  def new_response_to
    @showing_message = Message.find(params[:id])
    @response = Message.new
    if @showing_message.sender.class == EnrolledEmail
      @messageable = @showing_message.sender.classroom
    end
  end

  def create_response
    @showing_message = Message.find(params[:id])
    if defined? params[:response_to_messageable_group] and params[:response_to_messageable_group]
      @messageable = params[:messageable_group_type].classify.constantize.find(params[:messageable_group_id]) || not_found
    else
      @messageable = @showing_message.sender
    end
    @response = Message.new(sender: current_logged, receiver: @messageable, message: params[:message])
    if @response.save
      flash[:success] = t(:successfully_sent_message)
      redirect_to '/'
    else
      render 'new_response_to'
    end
  end
end
