Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # If an user is authenticated, root is dashboard page
  authenticated :user do
    root to: 'pages#supplies', as: :authenticated_root
  end

  # Defines the root path route ("/")
  root "pages#home"

  get "/supplies", to: "pages#supplies"

  resources :malts, except: [:show]
  resources :hops, except: [:show]
  resources :yeasts, except: [:show]
  resources :inventory_movements, only: [:new, :create]
  resources :recipes do
    resources :ingredient_items, except: [:index, :show]
  end
  resources :lots
  resources :general_configurations, only: [ :edit, :update ]
end
