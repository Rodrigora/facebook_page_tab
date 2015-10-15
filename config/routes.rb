Rails.application.routes.draw do
  root to: 'home#index'

  resources :facebook_requests, only: :create

  resources :facebook_pages, only: :index do
    resources :facebook_page_tabs, only: [:index, :create, :destroy]
  end

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
end
