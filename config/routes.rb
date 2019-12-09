Rails.application.routes.draw do
  devise_for :users
  root 'articles#index'
  resources :users do
    member do
      get 'favorite', to: 'users#favorite'
    end
  end
  resources :articles do
    member do
      post 'add', to: 'favorites#create'
      delete '/add', to: 'favorites#destroy'
    end
    collection do
      get 'list'
      get 'list_search', defaults: { format: 'json' }
      get 'search'
    end
  end
  resources :pictures do
    collection do
      get 'main_image', defaults: { format: 'json' }
    end
  end
  resources :prefectures, only: :show
end
