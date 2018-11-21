Rails.application.routes.draw do
  devise_for :users

  resources :products
  resources :users do
    resources :posts, only: [:index, :edit, :update, :destroy]
  end
  resources :carts, only: [:show, :create, :update, :destroy]
  get 'products/:id/create_post' => 'products#post', as: "post_products"
  get '/products/:id/post_users' => 'posts#posted_users', as: "post_users"

  get '/' => 'products#top'
  post '/products/:id/add_to_cart' => 'carts#add_item', as: "add_cart"
  delete '/delete_item/:id' => 'carts#delete_item', as: "delete_item"
  patch '/update_item/:id' => 'carts#update', as: "update_items"


  
  # カート画面の購入確定ボタンを押した時のアクション
  post '/carts/:id' => 'histories#create', as: 'purchase'
  # 購入履歴
  get '/histories/:id' => 'histories#show', as: 'history'
  patch '/histories/:id' => 'histories#update'
  get '/histories' => 'histories#index', as: 'histories'
  get '/users/:id/histories' => 'histories#index', as: 'user_histories'
  # ユーザーが退会ボタンを押して退会した時のアクション（論理削除）
  post '/users/:id/soft_destroy' => 'users#soft_destroy', as: 'soft_destroy'


  # 配送先
  get 'users/:id/destination' => 'users#destination_index', as: "destination_index"
  post 'users/:id/destination' => 'users#destination_create', as: "destination_create"
  get 'users/:id/destination/edit' => 'users#destination_edit', as: "dgglestination_edit"
  patch 'users/:id/destination/update' =>'users#destination_update', as: "destination_update"
  delete 'users/:id/destination/destroy' => 'users#destination_destroy', as: "destination_destroy"


end
