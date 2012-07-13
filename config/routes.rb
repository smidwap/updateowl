UpdateMe::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users

  root to: "home#dashboard"

  resources :students do
    get :preview, on: :member
    
    resources :messages, only: [:new, :create]
  end

  resources :users do
    resources :students, only: [] do
      get :select, on: :collection
    end
  end
end
