Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, :posts, :courses
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
end