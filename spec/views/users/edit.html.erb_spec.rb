# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/edit.html.erb', type: :view do
  let(:user) { FactoryBot.create(:user) }

  before do
    assign(:user, user)
    render
  end

  it 'displays the editing user header' do
    assert_select 'h1', text: 'Editing user'
  end

  it 'renders the form for editing the user' do
    assert_select "form[action='#{user_path(user)}'][method='post']" do
      assert_select 'fieldset' do
        assert_select 'legend', text: 'User Information'
        assert_select "input[name='user[first_name]'][type='text']"
        assert_select "input[name='user[last_name]'][type='text']"
        assert_select "input[name='user[pronouns]'][type='text']"
        assert_select "input[name='user[email]'][type='email']"
        assert_select "input[name='user[password]'][type='password']"
      end

      assert_select 'div.alert.alert-danger', count: 0

      assert_select "input[type='submit'][value='Submit']"
    end
  end

  it 'displays the links' do
    assert_select "a[href='#{user_path(user)}']", text: 'Show this user'
    assert_select "a[href='#{users_path}']", text: 'Back to users'
  end
end
