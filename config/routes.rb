Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

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
end
