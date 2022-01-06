# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'users/index'
  # get 'users/show'
  # get 'users/create'
  # get 'users/destroy'
  devise_for :users, controllers: { registrations: 'my_registrations' }
  resources :users
end
