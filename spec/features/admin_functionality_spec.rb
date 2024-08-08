# frozen_string_literal: true

require 'rails_helper'
require 'factory_bot_rails'
require_relative '../support/authentication_feature_helpers'

RSpec.describe 'Admin Functionality' do
  let(:admin) { FactoryBot.create(:admin) }
  let(:user) { FactoryBot.create(:user) }
  let(:availability) { FactoryBot.create(:availability) }

  before do
    login_user(admin)
  end

  describe 'Admin Viewing All Appointments' do
    let!(:appointment) { FactoryBot.create(:appointment, user:) }

    scenario 'Admin successfully views all appointments' do
      visit all_appointments_path

      expect(page).to have_content('All Appointments')
      expect(page).to have_content(appointment.availability.start_time.strftime('%Y-%m-%d %H:%M:%S'))
    end
  end

  describe 'Admin Creating New Availability' do
    scenario 'Admin successfully creates new availability' do
      visit new_availability_path

      fill_in 'Start time', with: 1.day.from_now.strftime('%Y-%m-%d %H:%M:%S')
      fill_in 'End time', with: (1.day.from_now + 2.hours).strftime('%Y-%m-%d %H:%M:%S')
      click_button 'Save Availability'

      expect(page).to have_content("Start time: #{1.day.from_now.strftime('%Y-%m-%d %H:%M:%S')}")
      expect(page).to have_content("End time: #{(1.day.from_now + 2.hours).strftime('%Y-%m-%d %H:%M:%S')}")
    end
  end

  describe 'Admin Editing Existing Availability' do
    scenario 'Admin successfully edits existing availability' do
      visit edit_availability_path(availability)

      fill_in 'Start time', with: 2.days.from_now.strftime('%Y-%m-%d %H:%M:%S')
      fill_in 'End time', with: (2.days.from_now + 2.hours).strftime('%Y-%m-%d %H:%M:%S')
      click_button 'Save Availability'

      expect(page).to have_content("Start time: #{2.days.from_now.strftime('%Y-%m-%d %H:%M:%S')}")
      expect(page).to have_content("End time: #{(2.days.from_now + 2.hours).strftime('%Y-%m-%d %H:%M:%S')}")
    end
  end

  describe 'Admin Deleting Availability' do
    scenario 'Admin successfully deletes availability' do
      visit availability_path(availability)

      expect(page).to have_content("Start time: #{availability.start_time.strftime('%Y-%m-%d %H:%M:%S')}")

      click_button 'Destroy this availability'
      expect(page).not_to have_content("Start time: #{availability.start_time.strftime('%Y-%m-%d %H:%M:%S')}")
    end
  end
end
