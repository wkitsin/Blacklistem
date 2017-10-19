Rails.application.routes.draw do
#   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#   root 'users#index'
#   get '/sessions/home'
#   resources :users 
#   get '/login' => "sessions#login"
#   get '/sessions/create' => "sessions#create"
#   delete '/sessions/destroy' => "sessions#destroy" ,as: 'sign_out'
#   get "/auth/google_oauth2/callback", to: "sessions#create_from_omniauth"
#   # devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
#   # get "/googlelogin", to: redirect("/auth/google_oauth2")/
# end

# GoogleAuthExample::Application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create_omniauth'
  get 'auth/failure', to: redirect('/')
  delete 'signout', to: 'sessions#destroy', as: 'signout'
  get '/search', to: 'home#search'
  resources :sessions, only: [:create]
  get 'login', to: 'sessions#login'
  resources :home
  resources :users, only: [:new, :create]
  get '/one/:id', to: 'home#one', as: 'one'
  root to: "home#show"
  get '/profile', to: 'users#show'
end
