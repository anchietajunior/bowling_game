Rails.application.routes.draw do
  resources :attempts, only: [:create]
  resources :games, only: [:create, :show]
end
