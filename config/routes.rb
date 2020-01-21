Rails.application.routes.draw do
  # get 'users/index'
  # get 'posts/index'
  resources :posts
  resources :users
    
  root to: 'home#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'about', to: 'home#about'
end
