require 'resque/server'

UpdateMe::Application.routes.draw do
  mount Resque::Server => "/resque"
  
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

    resources :parents
  end

  resources :users do
    resources :students, only: [:index] do
      get :select, on: :collection
    end

    resources :messages, controller: 'user_messages' do
      get :last_week, on: :collection
      get :unchecked, on: :collection
      get :student, on: :collection
    end
  end

  namespace :email do
    match "deliveries/:access_code" => "deliveries#show", as: :delivery, via: :get
  end

  namespace :phone do
    resources :deliveries, only: :show do
      get :route, on: :member
      get :next, on: :member
    end

    resources :parents do
      get :answer, on: :collection

      resources :deliveries, only: :index
    end
  end
end