# frozen_string_literal: true

module AuthenticationFeatureHelpers
  def login_user(user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Login'
  end
end
