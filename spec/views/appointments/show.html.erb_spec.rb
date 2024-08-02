# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'appointments/show' do
  before do
    assign(:appointment, Appointment.create!(
                           service: 'Service',
                           comments: 'Comments'
                         ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Service/)
    expect(rendered).to match(/Comments/)
  end
end
