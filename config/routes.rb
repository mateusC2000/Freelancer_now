Rails.application.routes.draw do
  root 'home#index'
  resources :projects, only: %i[show]
end
