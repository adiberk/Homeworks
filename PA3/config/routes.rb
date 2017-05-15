Rails.application.routes.draw do
  resources :enrollments
  resources :users
  get  '/subjects',    to: 'subjects#show'
  get  '/courses',   to: 'courses#show'
  get  '/instructors', to: 'instructors#show'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/search',    to: 'search#search'
  post '/search',    to: 'search#search'
  get '/course_results', to: 'search#index'
  get '/new_enrollments', to: 'enrollments#create'
  post '/new_enrollments', to: 'enrollments#create'
  root 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
