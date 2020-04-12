class AdminController < ApplicationController
  include AdminHelper
  after_action -> (param = TEACHER) {create_role param}, only: :create_teacher

  def show
  end

  def index
    @user = User.find_by_id(current_user.id)
  end

  def new
  end

  def edit
  end

  def delete
  end

  def teacher
    @teachers = User.get_teacher
  end

  def student
    @students = User.get_student
  end

  def course
    @courses = Course.all
  end

  def new_teacher
    @user = User.new
  end

  def new_course
    @course = Course.new
  end

  def course_subjects
    @course = Course.find_by_id(params[:id])
    @subjects = @course.subjects.all
  end

  def new_course_subject
    @subject = Course.find_by_id(params[:course_id]).subjects.new
  end

  def create_teacher
    add_password_field
    teacher_params = permit_teacher
    if User.create(teacher_params)
      flash[:notice] = "Teacher is created"
    end
    rescue Exception => e
      Rails.logger.info e.message
      Rails.logger.info e.backtrace
      flash[:alert] = "Teacher is not created"
    ensure
      redirect_to teacher_admin_index_path
  end

  def create_course
   course_params = permit_course
   if Course.create(course_params)
     flash[:notice] = "Course is created"
   end
   rescue Exception => e
     Rails.logger.info e.message
     Rails.logger.info e.backtrace
     flash[:alert] = "Course is not created"
   ensure
    redirect_to course_admin_index_path
  end

  def create_course_subject
    subject_params = permit_subject
    if Subject.create(subject_params)
      flash[:notice] = "Subject is created"
    end
    rescue Exception => e
      Rails.logger.info e.message
      Rails.logger.info e.backtrace
      flash[:alert] = "Subject is not created"
    ensure
      redirect_to subject_course_admin_path
  end

  def get_course_by_type
    course_type = params[:course_type]
    course = Course.where(course_type_id: course_type).pluck(:id,:name)
    render json: course
  end

  private
  def permit_teacher
    params.require(:user).permit(:email,:name,:number,:password, :course)
  end

  def permit_course
    params.require(:course).permit(:name, :course_type_id)
  end

  def permit_subject
    params.require(:subject).permit(:name,:course_id)
  end

  def add_password_field
    params[:user].merge!(:password => DEFAULT_PASSWORD)
  end
end
