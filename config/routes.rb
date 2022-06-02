# frozen_string_literal: true

require 'resque/server'
Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  mount Resque::Server.new, at: '/resque', constraints: AdminConstraint.new
  get 'sign_in', to: 'sessions#new', as: :new_session
  post 'sign_in', to: 'sessions#create', as: :session
  delete 'sign_out', to: 'sessions#destroy', as: :destroy_session

  get 'forgot_password', to: 'passwords#new', as: :new_password
  post 'forgot_password', to: 'passwords#create', as: :reset_password
  get 'reset_password', to: 'passwords#edit', as: :edit_password
  patch 'reset_password', to: 'passwords#update', as: :update_password
  get 'set_password', to: 'passwords#set', as: :set_password
  patch 'set_password', to: 'passwords#confirm', as: :confirm_password

  get 'sign_up', to: 'registrations#new', as: :new_sign_up
  post 'sign_up', to: 'registrations#create', as: :sign_up
  get 'profile', to: 'registrations#edit', as: :edit_profile
  put 'profile', to: 'registrations#update', as: :update_profile
  resources :accounts do
    get :history, on: :member
    get :activity, on: :member
    get :billing, on: :member
      resources :lists do
        get :index, on: :member
        get :history, on: :member
      end
      resources :records_transactions, except: %i(index)
      resources :users, except: %i(destroy) do
        get :history, on: :member
      end
      resources :products do
        get :index, on: :member
      end
  end
  resources :lists do
    get :index, on: :member
    get :show, on: :member
  end
  resources :products
  resources :users, except: %i(destroy) do
    get :history, on: :member
    resources :features, only: %i(index update)
  end

  get 'admin', to: 'admin#index'
  root :to => 'home#index'

  resources :users
end
