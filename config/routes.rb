Rails.application.routes.draw do
  devise_for :users

  resources :products
  resources :users do
  	resources :histories, only:[:index]
    resources :posts, only: [:index]
  end
  resources :posts, only: [:index, :create, :update, :destroy]
  resources :carts, only: [:show, :create, :update, :destroy]
  resources :histories, only: [:index, :show, :create, :update, :destroy]

  get '/' => 'products#top'
  post '/products/:id/add_to_cart' => 'carts#add_item', as: "add_cart"
  get '/products/:id/post_users' => 'posts#posted_users', as: "post_users"
  delete '/carts/:id' => 'carts#delete_item', as: "delete_item"

  # 配送先
  get 'users/:id/destination' => 'users#destination_index', as: "destination_index"
  post 'users/:id/destination' => 'users#destination_create', as: "destination_create"
  get 'users/:id/destination/edit' => 'users#destination_edit', as: "destination_edit"
  patch 'users/:id/destination/update' =>'users#destination_update', as: "destination_update"
  delete 'users/:id/destination/destroy' => 'users#destination_destroy', as: "destination_destroy"
end
