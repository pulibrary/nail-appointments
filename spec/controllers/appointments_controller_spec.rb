# frozen_string_literal: true

require 'rails_helper'
require 'rails-controller-testing'
require_relative '../support/controller_macros'

RSpec.describe AppointmentsController do
  let(:user_attributes) do
    {
      first_name: 'Megan',
      last_name: 'Lai',
      pronouns: 'she/her',
      email: '123@default.com',
      password: '2394jfi',
      role: 'user'
    }
  end

  let(:user) { User.create!(user_attributes) }
  let(:date) { Time.zone.today.to_s }

  let(:availability_attributes) do
    {
      start_time: Date.tomorrow.beginning_of_day + 1.hour,
      end_time: Date.tomorrow.beginning_of_day + 2.hours
    }
  end

  let(:appointment_attributes) do
    {
      availability_id: 1,
      service: 'Manicure',
      comments: 'White tips'
    }
  end

  let(:new_attributes) do
    {
      service: 'Pedicure',
      comments: 'Pink French'
    }
  end

  before(:each) do
    login_user(user)
  end

  describe 'GET /appointments' do
    it 'successfully renders the index view for the user\'s appointments' do
      get :index, params: { user_id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'successfully renders the show view for the specified appointment' do
      Availability.create!(availability_attributes.merge(id: 1))
      appointment = user.appointments.create!(appointment_attributes)

      get :show, params: { user_id: user.id, id: appointment.id }

      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'successfully renders the new appointment form and initializes a new appointment' do
      # Create availability slots for the specific date
      Availability.create!(availability_attributes)

      get :new, params: { user_id: user.id, day: date }
      expect(response).to be_successful

      # Ensure appointment is initialized
      expect(assigns(:appointment)).to be_a_new(Appointment)
    end
  end

  describe 'GET /edit' do
    it 'successfully renders the edit form for the specified appointment' do
      Availability.create!(availability_attributes.merge(id: 1))
      appointment = user.appointments.create!(appointment_attributes)

      get :edit, params: { user_id: user.id, id: appointment.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'creates a new appointment and redirects to the appointment show page' do
      # Create availability slots for the specific date
      Availability.create!(availability_attributes.merge(id: 1))

      post :create, params: { user_id: user.id, appointment: appointment_attributes }

      expect(response).to redirect_to(user_appointment_path(user, Appointment.last))
    end
  end

  describe 'PATCH #update' do
    it 'updates the specified appointment and redirects to the appointment show page' do
      Availability.create!(availability_attributes.merge(id: 1))
      appointment = user.appointments.create!(appointment_attributes)

      patch :update, params: { user_id: user.id, id: appointment.id, appointment: new_attributes }

      expect(response).to redirect_to(user_appointment_path(user, appointment))
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the specified appointment and redirects to the appointments index' do
      Availability.create!(availability_attributes.merge(id: 1))
      appointment = user.appointments.create!(appointment_attributes)

      delete :destroy, params: { user_id: user.id, id: appointment.id }

      # Verify that the user was deleted
      expect(Appointment).not_to exist(appointment.id)

      expect(response).to redirect_to(user_appointments_path(user))
      expect(flash[:notice]).to eq('Appointment was successfully destroyed.')
    end
  end
end
