Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  # Defines the root path route ("/")
  root "events#index"


  namespace :api do
    get "events"
    get "tags"
    get "login"
    get "register"
  end

  # api/login/paran...

  ## both are same
  # resources :api, only: [] do
  #   collection do
  #     get :events
  #     get :search
  #   end
  # end
  
  get 'tags/index'

  # handling all requests related to events
  # get "/events", to: "events#index"
  resources :events
  resources :tags
end
