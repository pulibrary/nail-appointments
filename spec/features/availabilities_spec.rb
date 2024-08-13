# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Availabilities Management' do
  let(:admin) { FactoryBot.create(:admin) }
  let(:availability) { FactoryBot.create(:availability) }

  before do
    login_user(admin)
  end

  describe 'Creating New Availability' do
    scenario 'Admin successfully creates a new availability' do
      visit new_availability_path

      fill_in 'Start time', with: 2.days.from_now.strftime('%Y-%m-%d %H:%M:%S')
      fill_in 'End time', with: (2.days.from_now + 1.hour).strftime('%Y-%m-%d %H:%M:%S')
      click_button 'Save Availability'

      expect(page).to have_content("Start time: #{2.days.from_now.strftime('%Y-%m-%d %H:%M:%S')}")
      expect(page).to have_content("End time: #{(2.days.from_now + 1.hour).strftime('%Y-%m-%d %H:%M:%S')}")
    end
  end

  describe 'Editing Existing Availability' do
    scenario 'Admin successfully edits an existing availability' do
      visit edit_availability_path(availability)

      fill_in 'Start time', with: 3.days.from_now.strftime('%Y-%m-%d %H:%M:%S')
      fill_in 'End time', with: (3.days.from_now + 2.hours).strftime('%Y-%m-%d %H:%M:%S')
      click_button 'Save Availability'

      expect(page).to have_content("Start time: #{3.days.from_now.strftime('%Y-%m-%d %H:%M:%S')}")
      expect(page).to have_content("End time: #{(3.days.from_now + 2.hours).strftime('%Y-%m-%d %H:%M:%S')}")
    end
  end

  describe 'Deleting Availability' do
    scenario 'Admin successfully deletes an availability' do
      visit availability_path(availability)

      expect(page).to have_content("Start time: #{availability.start_time.strftime('%Y-%m-%d %H:%M:%S')}")

      click_button 'Destroy this availability'
      expect(page).not_to have_content("Start time: #{availability.start_time.strftime('%Y-%m-%d %H:%M:%S')}")
    end
  end
end
