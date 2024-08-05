# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'appointments/new.html.erb', type: :view do
  let(:user) { FactoryBot.create(:user) }
  let(:date) { Time.zone.now + 1.day }
  let(:time_slot1) { FactoryBot.create(:availability, start_time: Time.zone.now + 1.day, end_time: Time.zone.now + 1.day + 1.hour) }
  let(:time_slot2) { FactoryBot.create(:availability, start_time: Time.zone.now + 1.day + 2.hours, end_time: Time.zone.now + 1.day + 3.hours) }
  let(:appointment) { FactoryBot.create(:appointment) }

  before do
    assign(:user, user)
    assign(:date, Time.zone.now + 1.day)
    assign(:time_slots, [time_slot1, time_slot2])
    assign(:appointment, appointment)
    allow(view).to receive(:current_user).and_return(user)
    render
  end

  it 'renders the form to select a day' do
    expect(rendered).to have_selector("form[action='#{new_user_appointment_path(user)}']")
    expect(rendered).to have_field('Select Day', type: 'date', with: date.strftime('%Y-%m-%d'))
    expect(rendered).to have_button('Find Time Slots')
  end

  it 'displays available time slots if they exist' do
    expect(rendered).to have_content("Available Time Slots on #{(Time.zone.now + 1.day).strftime('%B %d, %Y')}:")
    
    time_slots = [time_slot1, time_slot2]
    time_slots.each do |slot|
      expect(rendered).to have_selector("option[value='#{slot.id}']", text: "#{slot.start_time.strftime('%H:%M')} - #{slot.end_time.strftime('%H:%M')}")
    end

    expect(rendered).to have_field('Service', placeholder: 'Enter service type')
    expect(rendered).to have_field('Comments', placeholder: 'Enter any additional comments')
    expect(rendered).to have_button('Book Appointment')
  end

  it 'shows a message if no time slots are available' do
    assign(:time_slots, [])
    render
    expect(rendered).to have_content('No time slots available for the selected day.')
  end

  it 'does not display edit availabilities link for regular users' do
    expect(rendered).not_to have_link('Edit Availabilities')
  end

  it 'displays the show all appointments link' do
    expect(rendered).to have_link('Show all appointments', href: user_appointments_path(user))
  end

  it 'displays the back to dashboard link' do
    expect(rendered).to have_link('Back to Dashboard', href: user_dashboard_path(user))
  end
end