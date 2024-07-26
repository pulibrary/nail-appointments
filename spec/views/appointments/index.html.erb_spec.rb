require 'rails_helper'

RSpec.describe "appointments/index", type: :view do
  before(:each) do
    assign(:appointments, [
      Appointment.create!(
        service: "Service",
        comments: "Comments"
      ),
      Appointment.create!(
        service: "Service",
        comments: "Comments"
      )
    ])
  end

  it "renders a list of appointments" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Service".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Comments".to_s), count: 2
  end
end
