Rails.application.routes.draw do

  devise_for :users, controllers: { 
    :omniauth_callbacks => 'users/omniauth_callbacks',
    :registrations => 'users/registrations'
  }

  get '/', to: 'users#index'

  resources :users, only: [:index, :show]
  resources :posts, only: [:index]

  

end
