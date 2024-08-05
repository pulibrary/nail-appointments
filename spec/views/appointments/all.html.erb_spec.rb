# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'appointments/all.html.erb', type: :view do
  let(:user) { FactoryBot.create(:user, first_name: 'Alicia', last_name: 'Kas') }
  let(:availability1) { FactoryBot.create(:availability, start_time: Time.zone.now + 1.day, end_time: Time.zone.now + 2.days) }
  let(:availability2) { FactoryBot.create(:availability, start_time: Time.zone.now + 1.day, end_time: Time.zone.now + 2.days) }
  let(:appointment1) { FactoryBot.create(:appointment, user: user, availability: availability1, service: 'Massage', comments: 'Relaxing') }
  let(:appointment2) { FactoryBot.create(:appointment, user: user, availability: availability2, service: 'Facial', comments: 'Brightening') }

  before do
    assign(:appointments, [appointment1, appointment2])
    allow(view).to receive(:current_user).and_return(user)
    render
  end

  it 'renders a list of appointments' do
    assert_select 'h1', text: 'All Appointments'

    assert_select 'th', text: 'User'
    assert_select 'th', text: 'Service'
    assert_select 'th', text: 'Comments'
    assert_select 'th', text: 'Start Time'
    assert_select 'th', text: 'End Time'

    assert_select 'tbody tr', count: 2 do
      assert_select 'td', text: 'Alicia Kas'
      assert_select 'td', text: 'Massage'
      assert_select 'td', text: 'Relaxing'
      assert_select 'td', text: appointment1.availability.start_time.strftime('%Y-%m-%d %H:%M:%S')
      assert_select 'td', text: appointment1.availability.end_time.strftime('%Y-%m-%d %H:%M:%S')
    end

    assert_select 'tbody tr', count: 2 do
      assert_select 'td', text: 'Alicia Kas'
      assert_select 'td', text: 'Facial'
      assert_select 'td', text: 'Brightening'
      assert_select 'td', text: appointment2.availability.start_time.strftime('%Y-%m-%d %H:%M:%S')
      assert_select 'td', text: appointment2.availability.end_time.strftime('%Y-%m-%d %H:%M:%S')
    end

    assert_select 'a', text: 'Back to Dashboard', href: user_dashboard_path(user)
  end
end