Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  # Defines the root path route ("/")
  root "events#index"
  get 'tags/index'

  namespace :api do
    resources :auth, only: [] do 
      collection do
        get :login, :register
      end
    end
    resources :events, only: [] do
      collection do
        get :tags, :event, :events, :register, :unregister
      end
    end
  end


  # handling all requests related to events
  # get "/events", to: "events#index"
  resources :events
  resources :tags
end
