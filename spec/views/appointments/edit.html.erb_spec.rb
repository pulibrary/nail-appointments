# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'appointments/edit' do
  let(:appointment) do
    Appointment.create!(
      service: 'MyString',
      comments: 'MyString'
    )
  end

  before do
    assign(:appointment, appointment)
  end

  it 'renders the edit appointment form' do
    render

    assert_select 'form[action=?][method=?]', appointment_path(appointment), 'post' do
      assert_select 'input[name=?]', 'appointment[service]'

      assert_select 'input[name=?]', 'appointment[comments]'
    end
  end
end
