class ApplicationController < ActionController::Base
  # grabs current user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # sets user using id number
  # could be signed in user or any other user depending on id num
  def set_user
    @user = User.find(params[:user_id])
  end
end
