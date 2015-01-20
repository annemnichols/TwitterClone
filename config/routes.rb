Rails.application.routes.draw do

  root 'tweets#index'

  root 'welcome#index'

  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users, only: [:show, :index] do
    resources :tweets, except: [:index]
  end

end
