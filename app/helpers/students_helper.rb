module StudentsHelper

  def get_student_classes_today
    student_course_id = @student.course.is_a?(Array) ? @student.course.map(&:to_i) : @student.course.to_i
    Teacher.where('course_type_id = ? AND course_id IN (?) AND start_datetime >=?',@student.course_type,student_course_id,Time.now)
  end
end
