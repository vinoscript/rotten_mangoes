RottenMangoes::Application.routes.draw do

  resources :movies do
    resources :reviews, only: [:new, :create]
  end

  resources :users

  resource :session, only: [:new, :create, :destroy]

  namespace :admin do
    resources :users do
      get :make_admin
    end
    # resources :movies do 
    #   resources :re
  end

  root to: 'movies#index'

end
