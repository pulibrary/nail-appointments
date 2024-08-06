# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'appointments/show.html.erb' do
  let(:user) { FactoryBot.create(:user) }
  let(:availability) { FactoryBot.create(:availability) }
  let(:appointment) { FactoryBot.create(:appointment, user:, availability:) }

  before do
    assign(:user, user)
    assign(:appointment, appointment)
    allow(view).to receive(:current_user).and_return(user)
    render
  end

  it 'displays the appointment details' do
    expect(rendered).to have_selector("div##{dom_id(appointment)}")

    expect(rendered).to have_selector('p', text: 'Start Time:')
    expect(rendered).to have_selector('p', text: appointment.availability.start_time.strftime('%Y-%m-%d %H:%M:%S'))

    expect(rendered).to have_selector('p', text: 'End Time:')
    expect(rendered).to have_selector('p', text: appointment.availability.end_time.strftime('%Y-%m-%d %H:%M:%S'))

    expect(rendered).to have_selector('p', text: 'Service:')
    expect(rendered).to have_selector('p', text: appointment.service)

    expect(rendered).to have_selector('p', text: 'Comments:')
    expect(rendered).to have_selector('p', text: appointment.comments)
  end

  it 'renders the edit and destroy links and back button' do
    expect(rendered).to have_link('Edit this appointment', href: edit_user_appointment_path(user, appointment))
    expect(rendered).to have_link('Back to Dashboard', href: user_dashboard_path(user))

    # Check for the destroy button
    expect(rendered).to have_button('Destroy this appointment')
  end
end
