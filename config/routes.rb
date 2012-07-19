UpdateMe::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users

  root to: "home#dashboard"

  resources :students do
    get :preview, on: :member
    
    resources :messages, controller: 'student_messages' do
      get :user, on: :collection
      get :unchecked, on: :collection
    end
  end

  resources :users do
    resources :students, only: [] do
      get :select, on: :collection
    end

    resources :messages, controller: 'user_messages' do
      get :last_week, on: :collection
      get :unchecked, on: :collection
      get :student, on: :collection
    end
  end
end