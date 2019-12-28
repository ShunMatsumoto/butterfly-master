Rails.application.routes.draw do
  devise_for :users
  root "lessons#index"

  resources :users, only: [:edit, :update]
  resources :lessons, only: [:new, :create, :edit, :update]
end
