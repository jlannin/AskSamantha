class SessionsController < ApplicationController
  #skip_before_filter :set_user
  def create
    auth=request.env["omniauth.auth"]
    user=User.find_by_provider_and_uid(auth["provider"],auth["uid"]) ||
      User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to recipes_path
  end
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'Logged out successfully.'
    redirect_to recipes_path
  end
end

