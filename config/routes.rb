Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' => "homes#about"
  get "users/:id/follower" => "users#follower" 
  
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get :follower, on: :member
    get :followed, on: :member
  end
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
  end 
  
  
 
  
end