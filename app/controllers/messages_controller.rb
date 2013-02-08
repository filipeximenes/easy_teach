class MessagesController < ApplicationController

  def enrolled_email_classroom
    @page_classroom = Classroom.find(params[:classroom_id])
    if !@page_classroom.nil?
      @enrolled_email = @page_classroom.enrolled_emails.find_by_email(params[:email].downcase)
      if !@enrolled_email.nil?
        message = Message.create(sender: @enrolled_email, receiver: @page_classroom, message: params[:message])
        flash[:success] = t(:successfully_sent_message)
        redirect_to classroom_show_path(@page_classroom) and return
      else
        flash.now[:error] = t(:enroled_email_not_found)
      end
    end
    @page_index = @page_classroom.index
    @page_indexable = @page_index.indexable
    render "classroom_show/classroom_page"
  end
end
