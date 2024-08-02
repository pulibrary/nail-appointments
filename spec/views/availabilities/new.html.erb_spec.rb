# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'availabilities/new' do
  before do
    assign(:availability, Availability.new(
                            filled_status: false
                          ))
  end

  it 'renders new availability form' do
    render

    assert_select 'form[action=?][method=?]', availabilities_path, 'post' do
      assert_select 'input[name=?]', 'availability[filled_status]'
    end
  end
end
