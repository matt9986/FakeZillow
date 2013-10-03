ZillowClone::Application.routes.draw do
  resource :session, except: [:edit, :update, :show]
  resource :users, only: [:create, :new]
  resources :listings do
    resource :favorite, only: [:create, :destroy]
  end
  resources :searches, only: [:new, :index]
  
  root to: "searches#new"
end
