# frozen_string_literal: true

module ControllerMacros
  def login_user(user)
    session[:user_id] = user.id
  end
end

RSpec.configure do |config|
  config.include ControllerMacros, type: :controller
end
