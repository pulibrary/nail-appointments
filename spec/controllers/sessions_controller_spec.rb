# frozen_string_literal: true

require 'rails_helper'
require 'rails-controller-testing'
require_relative '../support/controller_macros'

RSpec.describe SessionsController do
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

  describe 'GET #new' do
    it 'renders the login page' do
      user = User.create!(valid_attributes)
      get :new, params: { email: user.email }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'logs in and redirects to user dashboard' do
      user = User.create!(valid_attributes)
      post :create, params: { email: user.email, password: valid_attributes[:password] }

      expect(response).to redirect_to(user_dashboard_path(user))
      expect(flash[:notice]).to eq('Logged in successfully.')
      expect(session[:user_id]).to eq(user.id)
    end
  end

  describe 'POST #destroy' do
    it 'logsout and redirects to /' do
      user = User.create!(valid_attributes)
      login_user(user)

      post :destroy, params: { id: user.id }

      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Logged out successfully.')
      expect(session[:user_id]).to be_nil
    end
  end
end
