# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Appointments' do
  let(:user) { FactoryBot.create(:user) }
  let!(:availability) { FactoryBot.create(:availability) }

  before do
    login_user(user)
    Availability.class_eval do
      def start_time_in_future; end
    end
  end

  scenario 'User creates a new appointment' do
    visit new_user_appointment_path(user)

    fill_in 'Select Day', with: availability.start_time.strftime('%Y-%m-%d')
    click_button 'Find Time Slots'

    select "#{availability.start_time.strftime('%H:%M')} - #{availability.end_time.strftime('%H:%M')}",
           from: 'Time Slot'
    fill_in 'Service', with: 'Massage'
    fill_in 'Comments', with: 'Please use lavender oil'

    click_button 'Book Appointment'

    expect(page).to have_content('Appointment was successfully created.')
    expect(page).to have_content('Massage')
    expect(page).to have_content('Please use lavender oil')
  end

  describe 'Viewing Appointments' do
    scenario 'User views their appointments' do
      appointment = FactoryBot.create(:appointment, user:, availability:)

      visit user_dashboard_path(user)
      expect(page).to have_content('My Appointments')

      visit user_appointments_path(user)
      expect(page).to have_content(appointment.service)
      expect(page).to have_content(appointment.comments)
    end
  end
end
