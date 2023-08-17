Rails.application.routes.draw do
  get 'sessions/new'
  root 'pictures#index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :pictures
  resources :pictures do
    collection do
      post :confirm
    end
  end
end