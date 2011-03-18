Blog::Application.routes.draw do

  # config/routes.rb
  resource  :user_session
  resources :users
  resources :posts

  match "login",  :to => "user_sessions#new",     :as => "login"
  match "logout", :to => "user_sessions#destroy", :as => "logout"

  root      :to => "posts#index"
end
