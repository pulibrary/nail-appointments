# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'sessions/new.html.erb' do
  before do
    render
  end

  it 'displays the login form' do
    assert_select 'h2', text: 'Login'

    assert_select "form[action='#{login_path}'][method='post']" do
      assert_select 'input[name=email][type=email].form-control'
      assert_select 'input[name=password][type=password].form-control'
      assert_select 'input[type=submit][value=Login].btn.btn-primary'
    end

    assert_select 'div.alert.alert-danger', count: 0
  end

  it 'displays the back to sign up link' do
    assert_select "a[href='#{new_user_path}']", text: 'Back to sign up'
  end
end
