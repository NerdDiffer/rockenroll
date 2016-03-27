Rails.application.routes.draw do
  root 'home#index'

  resources :users
  resources :courses
  resources :rooms
  resources :meetings
  resources :enrollments
  resources :people
end
