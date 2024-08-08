# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users Management' do
  let(:admin_attributes) do
    {
      first_name: 'Angela',
      last_name: 'Zhen',
      pronouns: 'they/them',
      email: '22@default.com',
      password: '3io2jf',
      role: 'admin'
    }
  end

  let!(:user) { FactoryBot.create(:user, first_name: 'Megan', last_name: 'Lai') }
  let!(:admin) { FactoryBot.create(:admin, **admin_attributes) }

  before do
    login_user(admin)
  end

  describe 'Viewing Users List' do
    scenario 'Admin views the list of users' do
      visit users_path

      expect(page).to have_content('Megan Lai')
    end
  end

  describe 'Viewing User Details' do
    scenario 'Admin views a user\'s profile' do
      visit user_path(user)

      expect(page).to have_content('First name: Megan')
      expect(page).to have_content('Last name: Lai')
    end
  end

  describe 'Editing Existing User' do
    scenario 'Admin successfully edits an existing user' do
      visit edit_user_path(user)

      fill_in 'First Name', with: 'Jackie'
      fill_in 'Last Name', with: 'Ida'
      fill_in 'Email', with: 'jackie.ida@example.com'
      click_button 'Submit'

      expect(page).to have_content('First name: Jackie')
      expect(page).to have_content('Last name: Ida')
      expect(page).to have_content('jackie.ida@example.com')
    end
  end

  describe 'Deleting User' do
    scenario 'Admin successfully deletes a user' do
      visit users_path

      expect(page).to have_content('Megan Lai')

      visit user_path(user)
      click_button 'Destroy this user'
      expect(page).not_to have_content('Megan Lai')
    end
  end
end
