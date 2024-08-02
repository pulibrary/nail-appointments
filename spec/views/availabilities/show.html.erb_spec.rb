require 'rails_helper'

RSpec.describe "availabilities/show", type: :view do
  before(:each) do
    assign(:availability, Availability.create!(
      filled_status: false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/false/)
  end
end
