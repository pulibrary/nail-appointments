# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'availabilities/edit.html.erb' do
  let(:availability) do
    FactoryBot.create(:availability,
                      start_time: 1.day.from_now,
                      end_time: 1.day.from_now + 1.hour)
  end

  before do
    assign(:availability, availability)
    render
  end

  it 'renders the edit availability form' do
    assert_select 'form[action=?][method=?]', availability_path(availability), 'post' do
      assert_select 'div', text: 'error prohibited this availability from being saved:', count: 0

      assert_select 'label[for=?]', 'availability_start_time', text: 'Start time'
      assert_select 'input[name=?][type=?]', 'availability[start_time]', 'datetime-local'

      assert_select 'label[for=?]', 'availability_end_time', text: 'End time'
      assert_select 'input[name=?][type=?]', 'availability[end_time]', 'datetime-local'

      assert_select 'input[type=?]', 'submit'
    end
  end

  it 'renders the correct links' do
    assert_select 'a[href=?]', availability_path(availability), text: 'Show this availability'
    assert_select 'a[href=?]', availabilities_path, text: 'Back to availabilities'
  end
end
