Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # Remove the individual get routes since they're handled by resources
  resources :streaming_services, only: [:index, :show] do
    collection do
      get 'connect_spotify'
    end
  end
  
  root 'home#index'
end