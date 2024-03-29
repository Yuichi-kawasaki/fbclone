Rails.application.routes.draw do

  root to:  'sessions#new'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update, :index]
  resources :relationships, only: [:create, :destroy]
  resources :pictures do
    collection do
      post :confirm
    end
    member do
      patch :confirm
    end
  end
  resources :conversations do
    resources :messages
  end
  get 'relationships/create'
  get 'relationships/destroy'
end
