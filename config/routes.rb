Rails.application.routes.draw do
  get 'sessions/new'
  # get 'users/index'
  # get 'posts/index'
  root 'home#top'
  
  get    'login', to: 'sessions#new'
  post   'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :posts
  resources :users
    
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'about', to: 'home#about'
end
