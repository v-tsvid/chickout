Rails.application.routes.draw do
  root to: "produkts#index"
  mount Chickout::Engine => "/cart"
  resources :users
  resources :produkts
  
end
