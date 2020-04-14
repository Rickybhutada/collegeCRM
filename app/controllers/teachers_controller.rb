class TeachersController < ApplicationController
  include TeachersHelper
  before_action :check_teacher_already_completed_8_hours, only: [:create_class_for_subject]
  before_action :track_attendence, only: [:dashboard]
  before_action :user_role_can_perform


  def dashboard
    @classes = get_today_classes
  end

  def new_class_for_subject
    @teacher = Teacher.new
    classes = get_today_classes
    if classes
      @today_classes = get_today_classes_by_datatime
    end
    @time_now = (Time.now+1.hour).strftime('%H:00 %p')
  end

  def create_class_for_subject
    params[:teacher][:start_datetime] = params[:teacher][:start_datetime].to_datetime
    schedule_class_params = permit_schedule_class
    if Teacher.create(schedule_class_params)
      flash[:notice] = "Class is created"
    else
      flash[:alert] = "Class is created"
    end
    redirect_to teacher_dashboard_path
  end

  private
  def permit_schedule_class
    params.require(:teacher).permit(:user_id, :course_type_id, :course_id, :subject_id, :start_datetime)
  end

  def check_teacher_already_completed_8_hours
    schedule_class_count =  get_today_classes.size
    if schedule_class_count >=8
      flash[:alert] = "Your Today schedule limit is full"
      redirect_to teacher_dashboard_path
    end
  end

  def track_attendence
    Attendance.find_or_create_by(user_id:current_user.id, date:Time.now.beginning_of_day)
  end

  def user_role_can_perform
    unless is_teacher?
      restrict_user("Access Restricted")
    end
  end

end
