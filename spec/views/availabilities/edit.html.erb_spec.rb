# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'availabilities/edit' do
  let(:availability) do
    Availability.create!(
      filled_status: false
    )
  end

  before do
    assign(:availability, availability)
  end

  it 'renders the edit availability form' do
    render

    assert_select 'form[action=?][method=?]', availability_path(availability), 'post' do
      assert_select 'input[name=?]', 'availability[filled_status]'
    end
  end
end
