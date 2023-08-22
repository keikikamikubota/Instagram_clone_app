Rails.application.routes.draw do
  root 'pictures#index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :favorites, only: [:create, :destroy, :show]
  resources :contacts
  resources :pictures do
    collection do
      post :confirm
    end
  end
end