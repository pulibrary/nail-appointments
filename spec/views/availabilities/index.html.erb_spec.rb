# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'availabilities/index.html.erb' do
  let(:user) { FactoryBot.create(:user) }
  let(:availability1) do
    FactoryBot.create(:availability, start_time: 1.day.from_now, end_time: 1.day.from_now + 1.hour)
  end
  let(:availability2) do
    FactoryBot.create(:availability, start_time: 4.days.from_now, end_time: 4.days.from_now + 1.hour)
  end

  before do
    assign(:availabilities, [availability1, availability2])
    allow(view).to receive(:current_user).and_return(user)
    render
  end

  it 'displays a list of availabilities' do
    assert_select 'h1', text: 'Availabilities'

    assert_select 'div.card', count: 2

    [availability1, availability2].each do |availability|
      # Locate the specific card by matching its content
      expect(rendered).to have_selector('div.card', text: availability.start_time.strftime('%B %d, %Y')) do |card|
        card_text = card.text.strip.gsub(/\s+/, ' ') # Normalize whitespace

        expect(card_text).to include(availability.start_time.strftime('%B %d, %Y'))
        expect(card_text).to include("Start Time: #{availability.start_time.strftime('%H:%M')}")
        expect(card_text).to include("End Time: #{availability.end_time.strftime('%H:%M')}")
        expect(card_text).to include("Status: #{availability.filled_status ? 'Filled' : 'Available'}")
      end
    end
  end

  it 'renders the New Availability link' do
    assert_select 'a[href=?]', new_availability_path, text: 'New Availability'
  end

  it 'renders the Back to Dashboard link' do
    assert_select 'a[href=?]', user_dashboard_path(user), text: 'Back to Dashboard'
  end
end
