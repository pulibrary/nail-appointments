# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'appointments/all.html.erb' do
  let(:user) { FactoryBot.create(:user, first_name: 'Alicia', last_name: 'Kas') }
  let(:availability1) do
    FactoryBot.create(:availability, start_time: 1.day.from_now, end_time: 2.days.from_now)
  end
  let(:availability2) do
    FactoryBot.create(:availability, start_time: 1.day.from_now, end_time: 2.days.from_now)
  end
  let(:appointment1) do
    FactoryBot.create(:appointment, user:, availability: availability1, service: 'Massage', comments: 'Relaxing')
  end
  let(:appointment2) do
    FactoryBot.create(:appointment, user:, availability: availability2, service: 'Facial', comments: 'Brightening')
  end

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
