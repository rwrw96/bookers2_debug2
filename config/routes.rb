Rails.application.routes.draw do
  get 'room/show'
  get 'room/create'
  get 'chats/create'
    devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  
  get 'search/search'
  root 'homes#top'
  get 'home/about' => "homes#about"
  

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :followers, on: :member
    get :followeds, on: :member
  end
  
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
  end 
  
  resources :rooms, only: [:create, :show]
  resources :chats, only: [:create]
  
  resource :search, only: [:search]
end