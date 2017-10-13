Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'users#index'
  get '/sessions/home'
  resources :users 
  get '/login' => "sessions#login"
  get '/sessions/create' => "sessions#create"
  delete '/sessions/destroy' => "sessions#destroy" ,as: 'sign_out'
end
