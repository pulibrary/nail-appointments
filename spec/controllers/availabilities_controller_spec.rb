# frozen_string_literal: true

require 'rails_helper'
require 'rails-controller-testing'
require_relative '../support/controller_macros'

RSpec.describe AvailabilitiesController do
  let(:user_attributes) do
    {
      first_name: 'Megan',
      last_name: 'Lai',
      pronouns: 'she/her',
      email: '123@default.com',
      password: '2394jfi',
      role: 'admin'
    }
  end

  let(:availability_attributes) do
    {
      start_time: Date.today.beginning_of_day + 1.hour,
      end_time: Date.today.beginning_of_day + 2.hours
    }
  end

  let(:new_attributes) do
    {
      start_time: Date.today.beginning_of_day + 5.hour,
      end_time: Date.today.beginning_of_day + 7.hours
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      user = User.create!(user_attributes)
      login_user(user)

      get :index, params: { user_id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      user = User.create!(user_attributes)
      login_user(user)

      get :new, params: { user_id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      user = User.create!(user_attributes)
      login_user(user)

      availability = Availability.create!(availability_attributes.merge(id: 1))

      get :edit, params: { user_id: user.id, id: availability.id }
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      user = User.create!(user_attributes)
      login_user(user)

      availability = Availability.create!(availability_attributes.merge(id: 1))

      get :show, params: { user_id: user.id, id: availability.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'creates a new availability and redirects to the availability show page' do
      user = User.create!(user_attributes)
      login_user(user)

      post :create, params: { availability: availability_attributes }
      
      # Ensure the response was redirected to the availability show page
      expect(response).to redirect_to(availability_url(Availability.last))

      # Ensure the availability was created
      expect(Availability.last.start_time).to eq(availability_attributes[:start_time])
      expect(Availability.last.end_time).to eq(availability_attributes[:end_time])
    
      # Check for flash notice
      expect(flash[:notice]).to eq("Availability was successfully created.")
    end
  end

  describe 'PATCH #update' do
    it 'updates the specified availability and redirects to the updated availability show page' do
      user = User.create!(user_attributes)
      login_user(user)

      availability = Availability.create!(availability_attributes.merge(id: 1))
      
      patch :update, params: { id: availability.id, availability: new_attributes }
      
      expect(response).to redirect_to(availability_url(availability))
      expect(Availability.last.start_time).to eq(new_attributes[:start_time])
      expect(Availability.last.end_time).to eq(new_attributes[:end_time])
      expect(flash[:notice]).to eq("Availability was successfully updated.")
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the specified availability and redirects to the availabilities index' do
      user = User.create!(user_attributes)
      login_user(user)

      availability = Availability.create!(availability_attributes.merge(id: 1))
      
      delete :destroy, params: { id: availability.id }
      
      expect(Availability.exists?(availability.id)).to be_falsey
      expect(response).to redirect_to(availabilities_url)
      expect(flash[:notice]).to eq('Availability was successfully destroyed.')
    end
  end
end