Rails.application.routes.draw do
  
  root to: "home#index"
  
  devise_for :users, :controllers => {
  :registrations => 'users/registrations',
  :sessions => 'users/sessions'
  }
  
  devise_scope :user do
  get "login", to: "users/sessions#new"
  post "login", to: "users/sessions#create"
  get "sign_out", to: "users/sessions#destroy"
end

resources :users, :only => [:index, :show] do
  member do
    get :following, :followers
  end
  end

resources :habits, :only => [:new, :create, :edit, :update, :destroy] do
  member do
   get   :record
   get   :mission
   patch :complete
 end
end

resources :relationships, :only => [:create, :destroy]
end
