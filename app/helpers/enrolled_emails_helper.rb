module EnrolledEmailsHelper
  def index_from_classroom
    @page_index ||= classroom_from_editable_enrolled_email.index
  end

  def classroom_from_editable_enrolled_email
    @page_classroom ||= editable_enrolled_email.classroom
  end

  def editable_enrolled_email
    @enrolled_email ||= EnrolledEmail.find(params[:id]) || not_found
  end 

  def allow_enrolled_email_edition?
    index_from_classroom == current_index
  end
end
