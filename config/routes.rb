Rails.application.routes.draw do
  # get 'comments/new'
  # post 'comments/create'
  
  get 'sessions/new'
  # get 'users/index'
  # get 'posts/index'
  root 'home#top'
  
  get 'users/:id/likes', to: 'users#likes'
  get 'users/:id/comments', to: 'users#comments'
  
  get 'posts/search',to: 'posts#search'
  
  get 'users/destroy_confirm',to: 'users#destroy_confirm'
  post 'users/destroy_confirm',to: 'users#destroy'
  
  get 'posts/daily', to: 'posts#posts_trend_day'
  get 'posts/weekly', to: 'posts#posts_trend_week'
  get 'posts/monthly', to: 'posts#posts_trend_month'
  get 'posts/all_ranks'
  
  get    'login', to: 'sessions#new'
  post   'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :posts do
    resources :comments
  end
  
  resources :users
  # usernameにしたい
  # resources :users, path: '/', only: [:show, :edit, :update, :destroy]
  
  
  post 'likes/:post_id/create',to: 'likes#create'
  post 'likes/:post_id/destroy',to: 'likes#destroy'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'about', to: 'home#about'
  
end
