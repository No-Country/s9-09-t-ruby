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
    resources :mashes, except: [:index, :show, :destroy]
    patch :trigger, on: :member
  end
  resources :lots do
    patch :trigger, on: :member
    patch :trigger_todo, on: :member
  end
  resources :general_configurations, only: [ :edit, :update ]
end
