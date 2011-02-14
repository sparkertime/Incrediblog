class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_login
    return true if logged_in?
    redirect_to new_session_path
  end

  def logged_in=(value)
    session[:logged_in] = value
  end  

  def logged_in?
    session[:logged_in] == true
  end
end
