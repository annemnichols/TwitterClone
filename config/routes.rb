Rails.application.routes.draw do

  root 'tweets#index'

  devise_for :users, :controllers => { registrations: 'registrations', 
  																		 :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, only: [:show, :index] do
    resources :tweets, except: [:index]
  end

end
