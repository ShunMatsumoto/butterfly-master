Rails.application.routes.draw do
  devise_for :users
  root "lessons#index"

  resources :users, only: [:index, :edit, :update]
  resources :lessons, only: [:new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]

    namespace :api do
      resources :messages, only: :index, defaults: { format: "json" }  # defaultsオプションを利用して、このルーティングが来たらjson形式でレスポンスするよう指定
    end
  end
end
