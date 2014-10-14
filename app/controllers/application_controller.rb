class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :show_page_redirect
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end
  helper_method :current_user
  
  def signed_in?
    current_user.present?
  end
  
  def show_page_redirect
    if signed_in?
      redirect_to user_path(current_user)
    else
      redirect_to new_user_path
    end
  end
  helper_method :show_page_redirect
end
