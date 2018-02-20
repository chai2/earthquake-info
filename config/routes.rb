Rails.application.routes.draw do

  root 'regions#index'
  get '*path' => redirect('/') # Redirect invalid paths to root

  resources :regions
end
