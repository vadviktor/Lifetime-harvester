class SessionsController < ApplicationController
  def create
    #logger.debug 'Omniauth response'
    #logger.debug env["omniauth.auth"].to_yaml

    user              = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def auth_failure
    flash[:error] = params[:message]
    redirect_to root_url
  end
end
