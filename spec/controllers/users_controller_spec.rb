require 'rails_helper'
require_relative '../support/controller_macros.rb'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) {
    {
      first_name: "Megan",
      last_name: "Lai",
      pronouns: "she/her",
      email: "123@default.com",
      password: "2394jfi",
      role: 1
    }
  }

  describe "GET /" do
    it "renders a successful response" do
      User.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      user = User.create! valid_attributes
      login_user(user)  # Call login_user method with the created user
      get :show, params: { id: user.id }  # Pass the user's ID to show action
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      user = User.create! valid_attributes
      login_user(user)  # Call login_user method with the created user
      get :edit, params: { id: user.id }  # Pass the user's ID to show action
      expect(response).to be_successful
    end
  end
end