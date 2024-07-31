# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/controller_macros'

RSpec.describe UsersController do
  let(:valid_attributes) do
    {
      first_name: 'Megan',
      last_name: 'Lai',
      pronouns: 'she/her',
      email: '123@default.com',
      password: '2394jfi',
      role: 'admin'
    }
  end

  let(:new_attributes) do
    {
      email: '542@default.com'
    }
  end

  describe 'GET /' do
    it 'renders a successful response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'renders a successful response' do
      user = User.create! valid_attributes
      login_user(user) # Call login_user method with the created user
      get :show, params: { id: user.id } # Pass the user's ID to show action
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'renders a successful response' do
      user = User.create! valid_attributes
      login_user(user)
      get :edit, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'GET /dashboard' do
    it 'renders a successful response' do
      user = User.create! valid_attributes
      login_user(user)
      get :dashboard, params: { id: user.id }
      expect(response).to be_successful
    end
  end
  
  describe 'POST #create' do
    it 'creates a new user and redirects to the user dashboard' do
      post :create, params: { user: valid_attributes }
      created_user = User.last
      expect(response).to redirect_to(user_dashboard_path(created_user))
      expect(flash[:notice]).to eq('User was successfully created.')
    end
  end

  describe 'PATCH #update' do
    it 'updates the user and redirects to the user page' do
      user = User.create! valid_attributes
      login_user(user)
      patch :update, params: { id: user.id, user: new_attributes }
      
      expect(response).to redirect_to(user_url(user))
      expect(flash[:notice]).to eq('User was successfully updated.')
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the user and redirects to the users list' do
      user = User.create! valid_attributes
      login_user(user)
      delete :destroy, params: { id: user.id }
      
      # Verify that the user was deleted
      expect(User.exists?(user.id)).to be_falsey

      expect(response).to redirect_to(users_url)
      expect(flash[:notice]).to eq('User was successfully destroyed.')
    end
  end
end
