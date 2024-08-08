# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'appointments/new.html.erb' do
  let(:user) { FactoryBot.create(:user) }
  let(:date) { 1.day.from_now }
  let(:time_slot1) do
    FactoryBot.create(:availability, start_time: 1.day.from_now, end_time: 1.day.from_now + 1.hour)
  end
  let(:time_slot2) do
    FactoryBot.create(:availability, start_time: 1.day.from_now + 2.hours, end_time: 1.day.from_now + 3.hours)
  end
  let(:appointment) { FactoryBot.create(:appointment) }

  before do
    assign(:user, user)
    assign(:date, 1.day.from_now)
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
    expect(rendered).to have_content("Available Time Slots on #{1.day.from_now.strftime('%B %d, %Y')}:")

    time_slots = [time_slot1, time_slot2]
    time_slots.each do |slot|
      expect(rendered).to have_selector("option[value='#{slot.id}']",
                                        text: "#{slot.start_time.strftime('%H:%M')} - #{slot.end_time.strftime('%H:%M')}")
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

  it 'displays the back to dashboard link' do
    expect(rendered).to have_link('Back to Dashboard', href: user_dashboard_path(user))
  end
end
