require 'rails_helper'

RSpec.describe UsersController do
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
      get users_path
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      user = User.create! valid_attributes
      get user_path(user)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_user_path
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      user = User.create!(valid_attributes)
      get edit_user_path(user)
      expect(response).to be_successful
    end
  end
end