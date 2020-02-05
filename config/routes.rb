Rails.application.routes.draw do
  # get 'comments/new'
  # post 'comments/create'
  
  get 'sessions/new'
  # get 'users/index'
  # get 'posts/index'
  root 'home#top'
  
  get 'users/:id/likes', to: 'users#likes'
  
  
  get    'login', to: 'sessions#new'
  post   'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :posts do
    resources :comments
  end
  
  resources :users
  
  post 'likes/:post_id/create',to: 'likes#create'
  post 'likes/:post_id/destroy',to: 'likes#destroy'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'about', to: 'home#about'
  
end
