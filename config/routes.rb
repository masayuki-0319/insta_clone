Rails.application.routes.draw do

  root 'static_pages#home'
  get '/about',     to: 'static_pages#about'
  get '/tos',       to: 'static_pages#tos'

  #課題：deviseをよりRESTfulにする（path）。
  devise_for :users, skip: [:registrations, :sessions]
  as :user do
    get 'sign_up',          to: 'devise/registrations#new', as: :new_user_registration
    post'sign_up',          to: 'devise/registrations#create', as: :user_registration
    get 'users/:id/edit',   to: 'devise/registrations#edit', as: :edit_user_registration
    put 'users/:id/edit',   to: 'devise/registrations#update', as: :update_user_registration
    delete 'users/:id/edit',to: 'devise/registrations#destroy'
    get 'sign_in',          to: 'devise/sessions#new', as: :new_user_session
    post 'sign_in',         to: 'devise/sessions#create', as: :user_session
    match 'sign_out',       to: 'devise/sessions#destroy', as: :destroy_user_session, via: Devise.mappings[:user].sign_out_via
  end


  resources :users, only: [:show, :following, :followers] do
    member do
      get :following, :followers
      get :like
    end
  end
  resources :photos, only: [:index, :show, :create, :destroy]
  resources :user_relationships, only: [:create, :destroy]
  #課題０１：コード実装が難航したたため，Progateに準じた
  #resources :photo_likes, only: [:create, :destroy]
  post "photo_likes/:id/create",   to: "photo_likes#create"
  post "photo_likes/:id/destroy",  to: "photo_likes#destroy"
end
