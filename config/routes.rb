require 'resque/server'

UpdateMe::Application.routes.draw do
  ActiveAdmin.routes(self)
  
  match('/resque/admin/login' => redirect('/admin/login'))
  authenticate(:admin_user) do
    # routes to Resque web
    mount Resque::Server.new, :at => "/resque"
  end

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
    get :consistency, on: :member

    resources :students, only: [:index] do
      get :select, on: :collection
    end

    resources :messages, controller: 'user_messages' do
      get :last_week, on: :collection
      get :unchecked, on: :collection
      get :student, on: :collection
      get :new_mass, on: :collection
    end
  end

  resources :messages, only: [:show, :create]

  namespace :parental do
    namespace :web do
      resources :deliveries do
        get :feedback, on: :member
      end
      resources :parents
    end

    namespace :phone do
      resources :deliveries, only: :show do
        get :route, on: :member
        get :next, on: :member
        get :feedback, on: :member
      end

      resources :parents do
        get :answer, on: :collection

        resources :deliveries, only: :index do
          get :voicemail, on: :collection
        end
      end
    end
  end

  match "support" => "support#new", via: :get, as: :support
  match "support" => "support#create", via: :post, as: :support
end