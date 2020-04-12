class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  # before_action :configure_permitted_parameters, if: :devise_controller?

  # before_filter :set_cache_buster, :store_location, :authenticate_session
  # after_filter :store_location


  # def authenticate_session
  #   redirect_to root_path unless user_signed_in?
  # end
  #
  # def set_cache_buster
  #   response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
  #   response.headers["Pragma"] = "no-cache"
  #   response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  # end
  #
  # # store last url and post-login redirect to whatever the user last visited
  # def store_location
  #   return unless request.get?
  #   session[:previous_url] = request.fullpath
  # end


  # Check if user logged in or not
  def authenticate_session
    redirect_to root_path unless user_signed_in? || request.path == "/"
  end

  def is_admin?
    current_user.user_role[:role_id] == ADMIN
  end

  def is_student?
    current_user.user_role[:role_id] == STUDENT
  end

  def is_teacher?
    current_user.user_role[:role_id] == TEACHER
  end

  #
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  # end

end
