Rails.application.routes.draw do
  root to:  'sessions#new'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update]

  resources :pictures do
    member do
      post :confirm
      patch :confirm
    end
  end
end
