Rails.application.routes.draw do

  root 'static_pages#home'
  get '/about',     to: 'static_pages#about'
  get '/tos',       to: 'static_pages#tos'

  devise_for :users, :controllers => {
    :registrations  => 'users/registrations',
    :sessions       => 'users/sessions'
  }

  devise_scope :users do
    get '/sign_up',  to: 'users/registrations#new'
    get '/sign_in',  to: 'users/sessions#new'
    get '/sign_out', to: 'users/sessions#destroy'
  end
end
