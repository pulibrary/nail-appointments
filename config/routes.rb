Rails.application.routes.draw do
  resources :availabilities
  # establishes nested relationship
  # implies appointments belong to a specific user
  resources :users do
    resources :appointments do
      collection do
        get 'select_day'
      end
    end
  end
  
  get '/user/:id/dashboard', to: 'users#dashboard', as: 'user_dashboard'

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy', as: :logout

  root to: "users#new"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
 