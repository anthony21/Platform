Rails.application.routes.draw do
  get 'sign_in', to: 'sessions#new', as: :new_session
  post 'sign_in', to: 'sessions#create', as: :sessions
  delete 'sign_out', to: 'sessions#destroy', as: :destroy_session

  get 'sign_up', to: 'registrations#new', as: :new_sign_up
  post 'sign_up', to: 'registrations#create', as: :sign_up
  get 'profile', to: 'registrations#edit', as: :edit_profile
  put 'profile', to: 'registrations#update', as: :update_profile

  get 'forgot_password', to: 'passwords#new', as: :new_password
  post 'forgot_password', to: 'passwords#create', as: :reset_password
  get 'reset_password', to: 'passwords#edit', as: :edit_password
  patch 'reset_password', to: 'passwords#update', as: :update_password
  get 'set_password', to: 'passwords#set', as: :set_password
  patch 'set_password', to: 'passwords#confirm', as: :confirm_password
  
  
  root to: "home#index"
end
