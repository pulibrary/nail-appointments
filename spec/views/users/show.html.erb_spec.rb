# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/show.html.erb', type: :view do
  let(:user) { FactoryBot.create(:user, first_name: 'John', last_name: 'Doe', pronouns: 'he/him', email: 'john.doe@example.com', role: 'admin') }

  before do
    assign(:user, user)
    render
  end

  it 'displays the user details' do
    assert_select "div##{dom_id(user)}" do
      expect(rendered).to have_content('First name:')
      expect(rendered).to have_content(user.first_name)

      expect(rendered).to have_content('Last name:')
      expect(rendered).to have_content(user.last_name)

      expect(rendered).to have_content('Pronouns:')
      expect(rendered).to have_content(user.pronouns)

      expect(rendered).to have_content('Email:')
      expect(rendered).to have_content(user.email)

      expect(rendered).to have_content('Role:')
      expect(rendered).to have_content(user.role)
    end
  end

  it 'renders the edit link and other links' do
    assert_select "a[href='#{edit_user_path(user)}']", text: 'Edit this user'
    assert_select "a[href='#{users_path}']", text: 'See all users'
  end

  it 'renders the destroy button' do
    assert_select "button", text: 'Destroy this user'
  end
end
