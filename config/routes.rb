Rails.application.routes.draw do
  devise_for :users
  root 'articles#index'
  resources :articles
  resources :pictures do
    collection do
      get 'main_image', defaults: { format: 'json' }
    end
  end
  resources :prefectures, only: :show
end
