Rails.application.routes.draw do
  devise_for :users, skip: [:sessions]

  devise_scope :user do
    authenticated :user do
      root 'users#show', as: :authenticated_root
    end
    
    unauthenticated do
      root 'devise/sessions#new', as: :login
    end
    
    post    '/login',  to: 'devise/sessions#create', as: :user_session
    delete  '/logout', to: 'devise/sessions#destroy', as: :logout
  end

  resources :users
  
  resources :clients do
    resources :episodes, shallow: true do
      resources :contacts, shallow: true
    end
  end
 end
