# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users' do
  scenario 'User successfully registers and logs in' do
    visit '/'

    fill_in 'First Name', with: 'Alicia'
    fill_in 'Last Name', with: 'Smith'
    fill_in 'Pronouns', with: 'she/her'
    fill_in 'Email', with: '29430@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Submit'

    fill_in 'Email', with: '29430@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    expect(page).to have_content('Dashboard')
  end
end
