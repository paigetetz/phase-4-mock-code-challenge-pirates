Rails.application.routes.draw do
  resources :treasures, only: [:create]
  resources :islands, only: [:index]
  resources :pirates, only: [:index, :show, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
