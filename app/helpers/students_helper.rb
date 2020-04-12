module StudentsHelper

  def get_student_classes_today
    Teacher.where('course_type_id = ? AND course_id=? AND start_datetime >=?',@student.course_type,@student.course,Time.now)
  end
end
