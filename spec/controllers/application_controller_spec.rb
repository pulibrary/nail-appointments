# frozen_string_literal: true

require 'rails_helper'
require 'rails-controller-testing'
require_relative '../support/controller_macros'

RSpec.describe ApplicationController do
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

  describe 'method current_user' do
    it 'successfully grabs the currently logged in user' do
      user = User.create!(user_attributes)
      login_user(user)
      
      #CHANGE THIS
      get :index # perform a request to trigger the controller action

      expect(controller.current_user).to eq(user)
    end
  end
end