# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/index.html.erb', type: :view do
  let(:user1) { FactoryBot.create(:user, first_name: 'Axle', last_name: 'Minse') }
  let(:user2) { FactoryBot.create(:user, first_name: 'Imani', last_name: 'Iwo') }
  let(:current_user) { FactoryBot.create(:user) }

  before do
    assign(:users, [user1, user2])
    allow(view).to receive(:current_user).and_return(current_user)
    render
  end

  it 'displays a list of users' do
    assert_select 'h1', text: 'Users'

    assert_select 'div#users' do
      assert_select 'p' do
        assert_select "a[href=?]", user_path(user1), text: 'Show this user'
        assert_select "a[href=?]", user_path(user2), text: 'Show this user'
      end
    end
  end

  it 'renders the New User link' do
    assert_select "a[href=?]", new_user_path, text: 'New user'
  end

  it 'renders the Back to Dashboard link' do
    assert_select "a[href=?]", user_dashboard_path(current_user), text: 'Back to Dashboard'
  end
end
