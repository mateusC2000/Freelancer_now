Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  devise_for :developers
  devise_for :project_owners

  root 'home#index'

  resources :projects, only: %i[show] do
    get 'search', on: :collection
  end

  namespace :admin do
    resources :projects, only: %i[new create show edit update] do
      get 'my_projects', on: :collection
    end
    resources :proposals do
      post 'accept', on: :member
      post 'recused', on: :member
      get 'candidate_profile', on: :member
    end
  end

  namespace :user do
    resources :project_categories, only: %i[show]
    resources :developer_profiles, only: %i[new create show edit update]
    resources :projects, only: %i[show] do
      get 'search', on: :collection
      resources :proposals, only: %i[index create show] do
        post 'canceled', on: :member
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :projects, only: %i[index show create]
      post 'login', to: 'api#login'
    end
  end
end
