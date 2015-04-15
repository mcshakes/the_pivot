Rails.application.routes.draw do
  root to: 'home#index'

  resources :vendors, path: "store", param: "slug"

  namespace :vendors, as: :vendor, path: "/:slug" do
    resources :items
    resource  :dashboard, only: :show
  end

    get  '/login'     => 'sessions#new'
    post '/login'     => 'sessions#create'
    get  '/logout'    => 'sessions#destroy'
    get  '/dashboard' => 'dashboard#show'
    get  "/account"   =>  "users#show"

  resources :users
  resources :favorites
  resources :addresses


  resources :cart_items, only: [:create, :update, :destroy]
  get "/cart", to: "cart_items#index"
  post "/checkout", to: "orders#create"


end
