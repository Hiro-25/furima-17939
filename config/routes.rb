Rails.application.routes.draw do
  devise_for :users
  resources :itmes, only: :index
  resources :items, only: :index
end