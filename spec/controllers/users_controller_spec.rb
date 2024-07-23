require './spec/spec_helper.rb'
require './app/controllers/users_controller.rb'

RSpec.describe UsersController do
  it 'creates a user and redirects to the user dashboard' do
    get "/"
    expect(response).to render_template(:new)

    post "/users", :params => {
      :user => {
        :first_name => "Megan",
        :last_name => "Lai",
        :pronouns => "she/her",
        :email => "123@default.com",
        :role => 1
      }
    }
    expect(response).to render_template(:dashboard)
  end
end