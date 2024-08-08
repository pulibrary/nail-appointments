# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'appointments/index.html.erb' do
  let(:user) { FactoryBot.create(:user) }
  let(:appointment1) { FactoryBot.create(:appointment, user:, service: 'Massage', comments: 'Relaxing') }
  let(:appointment2) { FactoryBot.create(:appointment, user:, service: 'Facial', comments: 'Brightening') }

  before do
    assign(:user, user)
    assign(:appointments, [appointment1, appointment2])
    render
  end

  it 'renders a list of appointments' do
    expect(rendered).to have_selector('h1', text: 'Appointments')

    expect(rendered).to have_link('Show this appointment', href: user_appointment_path(user, appointment1))
    expect(rendered).to have_link('Show this appointment', href: user_appointment_path(user, appointment2))

    expect(rendered).to have_content('Massage')
    expect(rendered).to have_content('Relaxing')
    expect(rendered).to have_content('Facial')
    expect(rendered).to have_content('Brightening')
  end

  it 'shows a message when there are no appointments' do
    assign(:appointments, [])
    render
    expect(rendered).to have_selector('p', text: 'No appointments to show.')
  end

  it 'displays the correct links' do
    expect(rendered).to have_link('New Appointment', href: new_user_appointment_path(user))
    expect(rendered).to have_link('Back to Dashboard', href: user_dashboard_path(user))
  end
end
