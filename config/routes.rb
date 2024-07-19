Rails.application.routes.draw do
  resources :users
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "/login", to: "users#login", as: "login"

  get "users/:id/dashboard", to: "users#dashboard", as: "user_dashboard"

  root to: "users#new"
end
 