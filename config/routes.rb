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
  delete '/delete_item/:id' => 'cars#delete_item', as: "delete_item"
  patch '/update_item/:id' => 'cars#update', as: "update_items"
end
