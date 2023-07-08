Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/supplies", to: "pages#supplies"

  resources :malts, except: [:show]
  resources :hops, except: [:show]
  resources :yeasts, except: [:show]
  resources :inventory_movements, only: [:new, :create]
end
