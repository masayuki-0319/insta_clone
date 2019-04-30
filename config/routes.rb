Rails.application.routes.draw do

  root 'static_pages#home'
  get '/about',     to: 'static_pages#about'
  get '/tos',       to: 'static_pages#tos'

  #課題：deviseをよりRESTfulにする（path）。
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

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
