# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :students
  devise_for :teachers
  resources :students
  resources :teachers
  resources :reviews
  delete '/comments', to: 'reviews#comment_destroy_all', as: 'comment'
end
