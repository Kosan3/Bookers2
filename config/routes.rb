Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  resources :books
  resources :users, only: [:index,:show,:edit,:update] do
  	resource :relationships, only: [:create, :destroy]
  	get :follows, on: :member
  	get :followers, on: :member
  end
  resources :chats, only: [:show, :create]
  get "home/about" => "homes#about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
