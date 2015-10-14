Rails.application.routes.draw do
  root to: 'home#index'

  resources :facebook_requests, only: :create

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
end
