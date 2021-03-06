class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    if Rails.env.development?
      session[:user_id] = 1
      @current_user ||= User.find(session[:user_id])
    else
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end

  helper_method :current_user
end
