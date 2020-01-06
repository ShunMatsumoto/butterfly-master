Rails.application.routes.draw do
  devise_for :users
  root "lessons#index"

  delete 'messages/:id' => 'messages#destroy'

  resources :users, only: [:index, :edit, :update]
  resources :lessons, only: [:new, :create, :edit, :update] do
    resources :messages, only: [:index, :create, :destroy]

    namespace :api do
      resources :messages, only: :index, defaults: { format: "json" }  # defaultsオプションを利用して、このルーティングが来たらjson形式でレスポンスするよう指定
    end
  end
end
