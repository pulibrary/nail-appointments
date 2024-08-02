# frozen_string_literal: true

class AppointmentsController < ApplicationController
  include Authenticatable
  before_action :set_user
  before_action :set_appointment, only: %i[show edit update destroy]

  def index
    @appointments = @user.appointments
  end

  def show; end

  def new
    @appointment = @user.appointments.build
    if params[:day].present?
      @date = params[:day]
      @date = Date.parse(@date)
      start_of_day = @date.beginning_of_day
      end_of_day = @date.end_of_day

      @time_slots = Availability.where('start_time >= ? AND end_time <= ?', start_of_day, end_of_day)
    else
      @time_slots = []
    end
  end

  def edit; end

  def create
    @appointment = @user.appointments.build(appointment_params)
    @appointment.user_id = current_user.id
    
    if @appointment.save
      redirect_to user_appointment_path(@user, @appointment), notice: 'Appointment was successfully created.'
    else
      render :new
    end
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

  def set_appointment
    @appointment = @user.appointments.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:user_id, :availability_id, :service, :comments)
  end
end
