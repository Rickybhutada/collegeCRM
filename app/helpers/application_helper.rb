module ApplicationHelper
  def get_course_type(id)
    CourseType.find {|f|  f[:id] == id}[:name]
  end

  def get_course_name(id)
    Course.find {|f|  f[:id] == id}[:name]
  end

  def get_teacher_name(id)
    User.find{|f| f[:id]==id}[:name]
  end

  def get_subject_name(id)
    Subject.find{|f| f[:id]==id}[:name]
  end
end
