Rails.application.routes.draw do
  devise_for :users
  root 'articles#index'
  resources :users, only:[:show, :edit]
  resources :articles do
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
