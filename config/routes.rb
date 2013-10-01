ZillowClone::Application.routes.draw do
  resource :session, except: [:edit, :update, :show]
  resource :users
  resources :listings
end
