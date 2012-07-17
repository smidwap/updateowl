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

    resources :messages, controller: 'user_messages' do
      get :last_week, on: :collection
      get :unchecked, on: :collection
    end
  end
end
