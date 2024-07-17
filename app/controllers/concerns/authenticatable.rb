# frozen_string_literal: true

module Authenticatable
  extend ActiveSupport::Concern

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authenticate_user
    return if current_user

    flash[:alert] = 'Please log in.'
    redirect_to login_path
  end
end
