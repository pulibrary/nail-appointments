# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'availabilities/index.html.erb', type: :view do
  let(:user) { FactoryBot.create(:user) }
  let(:availability1) { FactoryBot.create(:availability, start_time: Time.zone.now + 1.day, end_time: Time.zone.now + 1.day + 1.hour) }
  let(:availability2) { FactoryBot.create(:availability, start_time: Time.zone.now + 2.days, end_time: Time.zone.now + 2.days + 1.hour) }

  before do
    assign(:availabilities, [availability1, availability2])
    allow(view).to receive(:current_user).and_return(user)
    render
  end

  it 'displays a list of availabilities' do
    assert_select 'h1', text: 'Availabilities'

    [availability1, availability2].each do |availability|
      assert_select "div##{dom_id(availability)}"
      assert_select "a[href=?]", availability_path(availability), text: 'Show this availability'
    end
  end

  it 'renders the New Availability link' do
    assert_select "a[href=?]", new_availability_path, text: 'New availability'
  end

  it 'renders the New Appointment link' do
    assert_select "a[href=?]", new_user_appointment_path(user), text: 'New appointment'
  end

  it 'renders the To Dashboard link' do
    assert_select "a[href=?]", user_dashboard_path(user), text: 'To Dashboard'
  end
end
