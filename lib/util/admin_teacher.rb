module AdminTeacher

  def admin_teacher
    index = Index.find_by_slug(APP_CONFIG["application_name"])
    if index.nil?
      index = Index.create(slug: APP_CONFIG["application_name"])
      admin_teacher = Teacher.new(
                        name: APP_CONFIG["application_name"], last_name: "",
                        email: APP_CONFIG["application_default_email"], 
                        password: APP_CONFIG["application_default_email_password"],
                        password_confirmation: APP_CONFIG["application_default_email_password"]
                      )
      admin_teacher.index = index
      admin_teacher.save
    else
      admin_teacher = index.indexable
    end
    admin_teacher
  end
end