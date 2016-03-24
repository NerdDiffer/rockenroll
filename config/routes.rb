Rails.application.routes.draw do
  resources :users
  resources :courses
  resources :rooms
  resources :meetings
  resources :enrollments
  resources :people
end
