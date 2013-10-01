ZillowClone::Application.routes.draw do
  resource :session, except: [:edit, :update, :show]
  resource :users
  resources :listings
  resources :searches, only: [:new, :index]
  
  root to: "searches#new"
end
