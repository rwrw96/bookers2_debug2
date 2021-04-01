Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  root 'homes#top'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
    resource :favorites
  end   
  
  get 'home/about' => "homes#about"
  
end