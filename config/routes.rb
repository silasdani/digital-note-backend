# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'users/index'
  # get 'users/show'
  # get 'users/create'
  # get 'users/destroy'
  devise_for :users, controllers: { sessions: 'my_application_sessions' }
  # resources :users
end
