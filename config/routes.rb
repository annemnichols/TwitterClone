Rails.application.routes.draw do

  get 'users/show'

  get 'users/index'

  root 'welcome#index'

  devise_for :users, :controllers => { registrations: 'registrations' }

end
