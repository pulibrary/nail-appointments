# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/show' do
  before do
    assign(:user, User.create!(
                    first_name: 'First Name',
                    last_name: 'Last Name',
                    pronouns: 'Pronouns',
                    email: 'Email',
                    password: 'Password',
                    role: 2
                  ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Pronouns/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Password/)
    expect(rendered).to match(/2/)
  end
end
