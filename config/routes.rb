Rails.application.routes.draw do

  resources :users
  resources :rides
  resources :attractions
  root "static#index"
  get "/signin" => "sessions#new"
  post "/signin" => "sessions#create"
  delete "/signout" => "sessions#destroy"

end
