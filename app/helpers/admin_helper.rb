module AdminHelper
  def create_role(role_id)
    if params[:user].presence
      user = User.find_by_email(params[:user][:email])
      user.create_user_role(role_id: role_id)
    end
  end

  def get_course_type(id)
    CourseType.find {|f|  f[:id] == id}[:name]
  end

  def get_course(id)
    Course.find {|f|  f[:id] == id}[:name]
  end

  def get_subject(id)
    Subject.find {|f|  f[:id] == id}[:name]
  end
end
