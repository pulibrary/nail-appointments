# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'appointments/edit.html.erb', type: :view do
  let(:admin) { FactoryBot.create(:admin) }
  let(:user) { FactoryBot.create(:user) }
  let(:availability) { FactoryBot.create(:availability, start_time: Time.zone.now + 1.day, end_time: Time.zone.now + 1.day + 1.hour) }
  let(:appointment) { FactoryBot.create(:appointment, user: user, availability: availability, service: 'Gel Manicure', comments: 'Cat Eye Gel') }

  before do
    assign(:appointment, appointment)
    assign(:user, user)
    assign(:time_range, "#{appointment.availability.start_time.strftime('%Y-%m-%d %H:%M:%S')} - #{appointment.availability.end_time.strftime('%Y-%m-%d %H:%M:%S')}")
    allow(view).to receive(:current_user).and_return(admin)
    render
  end

  it 'displays the edit appointment form with pre-filled values' do
    assert_select 'form[action=?][method=?]', user_appointment_path(user, appointment), 'post' do
      assert_select 'input[name=?]', 'appointment[service]', value: 'Gel Manicure'
      assert_select 'textarea[name=?]', 'appointment[comments]', text: 'Cat Eye Gel'
      assert_select 'input[type=submit][value=?]', 'Save Appointment'
    end
  end

  it 'displays the correct links' do
    assert_select 'a[href=?]', user_appointment_path(user, appointment), text: 'Show this appointment'
    assert_select 'a[href=?]', user_dashboard_path(admin), text: 'Back to Dashboard'
  end

  it 'displays error messages if there are any' do
    appointment.errors.add(:base, "Sample error message")
    render

    assert_select 'div', text: /Sample error message/
  end

  it 'displays the time range' do
    assert_select 'div', text: @time_range
  end
end