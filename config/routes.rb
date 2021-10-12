Rails.application.routes.draw do
  devise_for :developers
  devise_for :project_owners
  root 'home#index'
  resources :projects, only: %i[show]

  namespace :admin do
    resources :projects, only: %i[new create show] do
      get 'my_projects', on: :collection
    end
  end

  namespace :user do
    resources :developer_profiles, only: %i[new create show]
  end
end
