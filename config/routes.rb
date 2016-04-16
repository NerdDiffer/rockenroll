Rails.application.routes.draw do
  root 'home#index'

  resources :users
  resources :courses
  resources :rooms
  resources :meetings
  resources :enrollments
  resources :people

  get 'contact', to: 'feedback#new'
  post 'contact', to: 'feedback#create'
end
