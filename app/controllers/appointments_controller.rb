class AppointmentsController < ApplicationController
  include Authenticatable
  before_action :set_user
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  def index
    @appointments = @user.appointments
  end

  def show
  end

  def new
    @appointment = @user.appointments.build
  end

  def create
    @appointment = @user.appointments.build(appointment_params)
    if @appointment.save
      redirect_to user_appointment_path(@user, @appointment), notice: 'Appointment was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to user_appointment_path(@user, @appointment), notice: 'Appointment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @appointment.destroy
    redirect_to user_appointments_path(@user), notice: 'Appointment was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_appointment
    @appointment = @user.appointments.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:service, :comments)
  end
end
