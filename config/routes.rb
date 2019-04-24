Rails.application.routes.draw do

  root 'static_pages#home'
  get '/about',     to: 'static_pages#about'
  get '/tos',       to: 'static_pages#tos'

  #devise_for :users, :controllers => {
  #  :registrations  => 'users/registrations',
  #  :sessions       => 'users/sessions'
  #}

  devise_for :users, skip: [:registrations, :sessions]
  as :user do
    get '/signup',  to: 'devise/registrations#new', as: :new_user_registration
    post'/signup',  to: 'devise/registrations#create', as: :user_registration
    get 'signin', to: 'devise/sessions#new', as: :new_user_session
    post 'signin', to: 'devise/sessions#create', as: :user_session
    match 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session, via: Devise.mappings[:user].sign_out_via
  end

  resources :users, only: [:show]
end
