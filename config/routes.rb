Rails.application.routes.draw do

  get 'tweets/index'

  get 'tweets/show'

  root 'welcome#index'

  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users, only: [:show, :index] do
    resources :tweets
  end

end
