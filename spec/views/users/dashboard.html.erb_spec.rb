# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/dashboard.html.erb', type: :view do
  let(:admin) { FactoryBot.create(:admin) }
  let(:user) { FactoryBot.create(:user) }

  context 'when an admin user is logged in' do
    before do
      assign(:user, admin)
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it 'displays the welcome message with the user\'s first name' do
      assert_select 'h1', text: 'Dashboard'
      assert_select 'p', text: "Welcome #{admin.first_name}"
    end

    it 'displays admin-specific links if the user is an admin' do
      assert_select 'p', text: 'Admin'
      assert_select "a[href='#{users_path}']", text: 'Show all users'
      assert_select "a[href='#{all_appointments_path}']", text: 'View All Appointments'
      assert_select "a[href='#{availabilities_path}']", text: 'Edit Availabilities'
    end

    it 'displays appointment links and logout form' do
      assert_select "a[href='#{new_user_appointment_path(admin)}']", text: 'Click here to make an appointment'
      assert_select "a[href='#{user_appointments_path(admin)}']", text: 'My Appointments'
      assert_select "form[action='#{logout_path}'][method='post']" do
        assert_select "input[type='submit'][value='Log Out']"
      end
    end
  end

  context 'when a regular user is logged in' do
    before do
      assign(:user, user)
      render
    end

    it 'displays the welcome message with the user\'s first name' do
      assert_select 'h1', text: 'Dashboard'
      assert_select 'p', text: "Welcome #{user.first_name}"
    end

    it 'does not display admin-specific links' do
      assert_select 'p', text: 'Admin', count: 0
      assert_select "a[href='#{users_path}']", count: 0
      assert_select "a[href='#{all_appointments_path}']", count: 0
      assert_select "a[href='#{availabilities_path}']", count: 0
    end

    it 'displays appointment links and logout form' do
      assert_select "a[href='#{new_user_appointment_path(user)}']", text: 'Click here to make an appointment'
      assert_select "a[href='#{user_appointments_path(user)}']", text: 'My Appointments'
      assert_select "form[action='#{logout_path}'][method='post']" do
        assert_select "input[type='submit'][value='Log Out']"
      end
    end
  end

  context 'when no user is logged in' do
    before do
      assign(:user, nil)
      render
    end

    it 'prompts to login' do
      assert_select 'p', text: 'Please login to access your dashboard.'
    end

    it 'does not display user or admin viewable items' do
      assert_select 'p', text: 'Welcome', count: 0
      assert_select 'p', text: 'Admin', count: 0
      assert_select "a[href='#{users_path}']", count: 0
      assert_select "a[href='#{all_appointments_path}']", count: 0
      assert_select "a[href='#{availabilities_path}']", count: 0
      assert_select "a[href='#{new_user_appointment_path(user)}']", count: 0
      assert_select "a[href='#{user_appointments_path(user)}']", count: 0
      assert_select "form[action='#{logout_path}'][method='post']", count: 0
    end
  end
end
