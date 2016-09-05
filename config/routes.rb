Chickout::Engine.routes.draw do
  root to: 'items#index'

  resources :items, only: [:index, :create, :destroy]
  resources :orders, only: [:index, :show, :update, :destroy]
  resources :checkouts, only: [:new, :create, :show, :update]

  delete 'items/delete_from_cookies'
end
