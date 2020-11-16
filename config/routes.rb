Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :boats do
    resources :bookings, only: [:new, :create]
  end
  resources :dashboard, only: [:index]
  resources :bookings, only: [:show, :edit, :update, :destroy]
end
