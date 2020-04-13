class StudentsController < ApplicationController
  include StudentsHelper

  def dashboard
    @student = User.find_by_id(params[:id])
    @today_classes = get_student_classes_today
  end

  def attend_class
    teacher_id = params["teacher_id"]
    subject_id = params["subject_id"]
    subject_class = Teacher.find_by('subject_id=? AND user_id=? AND start_datetime >= ?',subject_id,teacher_id,Time.now.beginning_of_day)
    if subject_class
      if ((Time.now.strftime('%a, %d %b %Y %H:%M:%S') <= subject_class.start_datetime.to_datetime) && (subject_class.start_datetime.to_datetime <= (Time.now+5.minutes).strftime('%a, %d %b %Y %H:%M:%S')))
        message = "You entered in the Class"
        track_attendence
      else
        message= "Sorry you only enetered in the class before the 5 minutes"
      end
    else
      message= "Sorry Something went wrong"
    end
    response = {message: message}
    respond_to do |format|
      format.json { render json: response, status: :ok }
    end
  end

  private
  def track_attendence
    Attendance.find_or_create_by(user_id:current_user.id, date:Time.now.beginning_of_day)
  end
end
