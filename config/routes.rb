Rails.application.routes.draw do
  root to: 'sessions#index'

  resources :vendors, path: "", param: "slug"

  namespace :vendors, as: :vendor, path: "/:slug" do
    resources :items
    resource  :dashboard, only: :show
  end

    get  '/login'     => 'sessions#new'
    post '/login'     => 'sessions#create'
    get  '/logout'    => 'sessions#destroy'
    get  '/dashboard' => 'dashboard#show'

  resources :users
  resources :cart_items, only: [:create, :update, :destroy]
  get "/cart", to: "cart_items#index"
  post "/checkout", to: "orders#create"


  # resources :orders do
  #   member do # for an individual order
  #     get "cancel"
  #     get "paid"
  #     get "complete"
  #   end
  # end
end


  #platform admin
  #gallery.com/dashboard

  #business admin
  #gallery.com/store_name/dashboard/

  #users
  #gallery.com
  #gallery.com/login
  #gallery.com/logout
  #gallery.com/cart
  #gallery.com/account
  #gallery.com/all-stores

  #gallery.com/:store_name
  #gallery.com/:store_name/items
  #gallery.com/:store_name/items/:id
