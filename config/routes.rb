Rails.application.routes.draw do
  resources :furimas, only: :index
  resources :items, only: :index
end