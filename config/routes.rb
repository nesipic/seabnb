Rails.application.routes.draw do
  get 'dashboard/index', to: "dashboard#index", as: "dashboard"

  devise_for :users
  root to: 'pages#home'
  get '/confirmation', to: 'pages#confirmation'
  resources :boats do
    resources :bookings, only: [:new, :create]
  end
  resources :dashboard, only: [:index]
  resources :bookings, only: [:show, :edit, :update, :destroy]
  resources :boats, only: [:destroy]
end
