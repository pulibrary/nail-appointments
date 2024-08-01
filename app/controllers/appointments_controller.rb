# frozen_string_literal: true

class AppointmentsController < ApplicationController
  include Authenticatable
  before_action :set_user, except: %i[ all ]
  before_action :set_appointment, only: %i[show edit update destroy]

  def index
    @appointments = @user.appointments
  end

  def show; end

  def new
    @appointment = @user.appointments.build
    if params[:day].present?
      @date = Date.parse(params[:day])
      start_of_day = @date.beginning_of_day
      end_of_day = @date.end_of_day

      # Filter time slots that are within the selected day, in the future, and have filled_status = false
      @time_slots = Availability.where(
        'start_time >= ? AND end_time <= ? AND filled_status = ?',
        [start_of_day, Time.current].max,
        end_of_day,
        false
      )
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
    begin
      # Temporarily mark the availability as not filled
      availability = @appointment.availability
      if availability.present?
        availability.update!(filled_status: false)
      end
  
      # Attempt to destroy the appointment
      @appointment.destroy
  
      redirect_to user_appointments_path(@user), notice: 'Appointment was successfully destroyed.'
    rescue StandardError => e
      # Rollback availability status change if appointment destruction fails
      if availability.present?
        availability.update!(filled_status: true)
      end
      
      # Log the error and show an error message
      Rails.logger.error("Failed to destroy appointment: #{e.message}")
      redirect_to user_appointments_path(@user), alert: 'Failed to destroy appointment. Please try again.'
    end
  end

  def all
    @appointments = Appointment.includes(:user, :availability).all
  end

  private

  def set_appointment
    @appointment = @user.appointments.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:user_id, :availability_id, :service, :comments)
  end
end
