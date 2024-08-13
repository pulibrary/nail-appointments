# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'availabilities/new.html.erb' do
  let(:availability) { FactoryBot.build(:availability) }

  before do
    assign(:availability, availability)
    render
  end

  it 'displays the new availability form' do
    assert_select 'h1', text: 'New availability'

    assert_select "form[action='#{availabilities_path}'][method='post']" do
      assert_select 'input[name=?][type=?]', 'availability[start_time]', 'datetime-local'

      assert_select 'input[name=?][type=?]', 'availability[end_time]', 'datetime-local'

      assert_select 'input[type=submit][value=?]', 'Create Availability'
    end
  end

  it 'displays the back to availabilities link' do
    assert_select 'a[href=?]', availabilities_path, text: 'Back to availabilities'
  end
end
