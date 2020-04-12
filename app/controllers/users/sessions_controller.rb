class Users::SessionsController < Devise::SessionsController
  before_filter :configure_sign_in_params, only: [:create]
  before_action :require_no_authentication, only: [:new ]
  # before_action :authenticate_session


  # GET /resource/sign_in
  # def new
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  #If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in)
  end

  # The path used after sign up.
  def after_sign_in_path_for(resource)
    if current_user.blank?
      restrict_user( "Login Restricted")
    elsif is_admin?
      session[:id] = current_user.id
      admin_index_path
    elsif is_teacher?
      session[:id] = current_user.id
      teacher_dashboard_path(current_user.id)
    elsif is_student?
      session[:id] = current_user.id
      student_dashboard_path(current_user.id)
    else
       restrict_user( "Login Restricted")
    end
  end

  def restrict_user( message)
    sign_out(resource_name)
    flash[:alert] = message
    root_path
  end
end
