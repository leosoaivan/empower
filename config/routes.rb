Rails.application.routes.draw do
  root    'sessions#new'
  
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'

  resources :users
  resources :clients do
    resources :episodes do
      resources :contacts
    end
  end
end
