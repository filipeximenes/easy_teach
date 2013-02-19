class MessagesController < ApplicationController
  include MessageAuthorization

  before_filter :authorize_visualization, only: [:show, :new_response_to]
  before_filter :extract_receiver, only: [:create_response_to]
  before_filter :authorize_send_to, only: [:new_message_to, :create_message_to, :create_response_to]

  def show
  end

  def new_message_to
    @message = Message.new
  end

  def create_message_to
    @message = Message.new(sender: current_logged, receiver: receiver, message: params[:message])
    if @message.save
      flash[:success] = t(:successfully_sent_message)
      redirect_to get_redirect_url
    else
      render 'new_message_to'
    end
  end

  def new_response_to
    @response = Message.new
    if @showing_message.sender.class == EnrolledEmail
      @classroom_messageable = @showing_message.sender.classroom
    end
  end

  def create_response_to
    @response = Message.new(sender: current_logged, receiver: receiver,
                            message: params[:message],
                            previous_message_text: @showing_message.message)
    if @response.save
      flash[:success] = t(:successfully_sent_message)
      redirect_to get_redirect_url
    else
      render 'new_response_to'
    end
  end

  def create_message_from_enrolled_email
    @classroom = Classroom.find(params[:classroom_id])
    if !@classroom.nil?
      @enrolled_email = @classroom.enrolled_emails.find_by_email(params[:email].downcase)
      if !@enrolled_email.nil?
        message = Message.create(sender: @enrolled_email, receiver: @classroom.owner, message: params[:message])
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
end
