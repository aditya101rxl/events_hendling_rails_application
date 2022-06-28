Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  # Defines the root path route ("/")
  root "events#index"
  
  get "events/addEvent"
  
  get 'tags/index'

  # handling all requests related to events
  # get "/events", to: "events#index"
  resources :events
  resources :tags
end
