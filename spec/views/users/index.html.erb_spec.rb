# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/index.html.erb' do
  let(:user1) { FactoryBot.create(:user, first_name: 'Axle', last_name: 'Minse', email: 'axle@example.com') }
  let(:user2) { FactoryBot.create(:user, first_name: 'Imani', last_name: 'Iwo', email: 'imani@example.com') }
  let(:current_user) { FactoryBot.create(:user) }

  before do
    assign(:users, [user1, user2])
    allow(view).to receive(:current_user).and_return(current_user)
    render
  end

  it 'displays the page heading' do
    assert_select 'h1', text: 'Users'
  end

  it 'renders the Back to Dashboard link' do
    assert_select 'a[href=?]', user_dashboard_path(current_user), text: 'Back to Dashboard'
  end

  it 'displays a list of users' do
    assert_select 'div.card', count: 2

    assert_select 'div.card-body' do
      assert_select 'h2.card-title', text: "#{user1.first_name} #{user1.last_name}"
      assert_select 'p.card-text', text: user1.email

      assert_select 'h2.card-title', text: "#{user2.first_name} #{user2.last_name}"
      assert_select 'p.card-text', text: user2.email

      assert_select 'a.btn[href=?]', user_path(user1), text: 'Show this user'
      assert_select 'a.btn[href=?]', user_path(user2), text: 'Show this user'
    end
  end
end
