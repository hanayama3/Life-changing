Rails.application.routes.draw do
  
  get 'users/show'
  devise_for :users, :controllers => {
  :registrations => 'users/registrations',
  :sessions => 'users/sessions'
  }
  
  devise_scope :user do
  get "users/sign_in", :to => "users/sessions#new"
  get "users/sign_out", :to => "users/sessions#destroy"
 
end
# get 'users/:id', :to => 'users#show'
 root to: "home#index"
end
