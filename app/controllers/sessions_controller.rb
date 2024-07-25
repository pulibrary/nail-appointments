# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
    @user = User.find_by(email: params[:email])
  end
  
  def create
    @user = User.find_by(email: params[:email])
  
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_dashboard_path(@user), notice: "Logged in successfully."
    else
      flash.now[:alert] = "Invalid email or password."
      render :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to '/', notice: "Logged out successfully."
  end
end