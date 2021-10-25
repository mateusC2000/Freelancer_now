Rails.application.routes.draw do
  devise_for :developers
  devise_for :project_owners
  root 'home#index'

  resources :projects, only: %i[show]

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
    resources :developer_profiles, only: %i[new create show edit update]
    resources :projects, only: %i[show] do
      resources :proposals, only: %i[index create show] do
        post 'canceled', on: :member
      end
    end
  end
end
