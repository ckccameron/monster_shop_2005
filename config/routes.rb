Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: "welcome#index"

  get "/merchants", to: "merchants#index"
  get "/merchants/new", to: "merchants#new"
  get "/merchants/:id", to: "merchants#show"
  post "/merchants", to: "merchants#create"
  get "/merchants/:id/edit", to: "merchants#edit"
  patch "/merchants/:id", to: "merchants#update"
  delete "/merchants/:id", to: "merchants#destroy"

  get "/items", to: "items#index"
  get "/items/:id", to: "items#show"
  get "/items/:id/edit", to: "items#edit"
  patch "/items/:id", to: "items#update"
  get "/merchants/:merchant_id/items", to: "items#index"
  get "/merchants/:merchant_id/items/new", to: "items#new"
  post "/merchants/:merchant_id/items", to: "items#create"
  delete "/items/:id", to: "items#destroy"

  get "/items/:item_id/reviews/new", to: "reviews#new"
  post "/items/:item_id/reviews", to: "reviews#create"

  get "/reviews/:id/edit", to: "reviews#edit"
  patch "/reviews/:id", to: "reviews#update"
  delete "/reviews/:id", to: "reviews#destroy"

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"
  patch "/cart/:item_id", to: "cart#update"

  get "/orders/new", to: "orders#new"
  post "/orders", to: "orders#create"
  get "/orders/:id", to: "orders#show"

  get "/register", to: "users#new"
  post "/users", to: "users#create"
  get "/profile", to: "users#show"
  get "/profile/edit", to: "users#edit"
  patch "/profile", to: "users#update"
  get "/profile/password/edit", to: "password#edit"
  patch "/profile/password", to: "password#update"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get '/logout', to: "sessions#destroy"

  get "/users", to: "users#index"

  namespace :merchant do
    get "/", to: "dashboard#index"
    get "/items", to: "items#index"
    delete "/items/:id", to: "items#destroy"
    get "/items/new", to: "items#new"
    post "/items", to: "items#create"
    patch "/items/:item_id", to: "items#update"
    get "/orders/:order_id", to: "orders#show"
    patch "/item_orders/:item_order_id", to: "item_orders#update"
    get "/items/:item_id/edit", to: "items#edit"

  end

  namespace :admin do
    get "/", to: "dashboard#index"
    get "/users", to: "users#index"
    get "/orders/:order_id", to: "orders#update"
    get "/merchants", to: "merchants#index"
    get "/merchants/:id", to: "merchants#show"
    patch "/merchants/:id", to: "merchants#update"
    get "/merchants/:id/items", to: "items#index"
    delete "/merchants/:merchant_id/items/:item_id", to: "items#destroy"
    get "/merchants/:merchant_id/items/new", to: "items#new"
    post "/merchants/:merchant_id/items/", to: "items#create"
    get "/users/:id", to: "users#show"
  end

  namespace :profile do
    get "/orders", to: "orders#index"
    get "/orders/:id", to: "orders#show"
    patch "/orders/:id", to: "orders#update"
  end
end
