# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'availabilities/show.html.erb' do
  let(:availability) do
    FactoryBot.create(:availability, start_time: 1.hour.from_now, end_time: 2.hours.from_now,
                                     filled_status: 'Available')
  end

  before do
    assign(:availability, availability)
    render
  end

  it 'displays the availability details' do
    assert_select "div##{dom_id(availability)}" do
      expect(rendered).to have_selector('p', text: 'Start time:')
      expect(rendered).to have_selector('p', text: availability.start_time.to_s)

      expect(rendered).to have_selector('p', text: 'End time:')
      expect(rendered).to have_selector('p', text: availability.end_time.to_s)

      expect(rendered).to have_selector('p', text: 'Filled status:')
      expect(rendered).to have_selector('p', text: availability.filled_status)
    end
  end

  it 'has the correct links and button' do
    assert_select "a[href='#{edit_availability_path(availability)}']", text: 'Edit this availability'
    assert_select "a[href='#{availabilities_path}']", text: 'Back to availabilities'
    assert_select 'button', text: 'Destroy this availability'
  end
end
