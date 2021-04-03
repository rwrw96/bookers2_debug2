Rails.application.routes.draw do
  get 'search/search'
  root 'homes#top'
  get 'home/about' => "homes#about"
  
  devise_for :users
  
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :followers, on: :member
    get :followeds, on: :member
  end
  
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
  end 
  
  resource :search, only: [:search]
end