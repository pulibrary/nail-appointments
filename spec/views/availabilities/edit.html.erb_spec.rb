require 'rails_helper'

RSpec.describe "availabilities/edit", type: :view do
  let(:availability) {
    Availability.create!(
      filled_status: false
    )
  }

  before(:each) do
    assign(:availability, availability)
  end

  it "renders the edit availability form" do
    render

    assert_select "form[action=?][method=?]", availability_path(availability), "post" do

      assert_select "input[name=?]", "availability[filled_status]"
    end
  end
end
