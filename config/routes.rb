Rails.application.routes.draw do
  get 'dashboard/index'
  get 'bookings/show'
  get 'bookings/new'
  get 'bookings/create'
  get 'bookings/edit'
  get 'bookings/update'
  get 'bookings/destroy'
  devise_for :users
  root to: 'pages#home'
  resources :boats do
    resources :bookings, only: [:new, :create]
  end
  resources :dashboard, only: [:index]
  resources :bookings, only: [:show, :edit, :update, :destroy]
  resources :boats, only: [:destroy]
end
