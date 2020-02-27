Rails.application.routes.draw do
  resources :meals
  root to: 'pages#home'
  devise_for :users
  resources :users, only: [:show, :edit, :update]

  get 'limit', to: 'users#limit_edit', as: 'edit_limit'
  post 'limit', to: 'users#limit_update'
  get 'history', to: 'meals#meals_history', as: 'meals_history'

  get 'filter', to: 'meals#filter_new', as: 'filter'
  post 'filter', to: 'meals#filter', as: 'filter_show'

  get 'manager', to: 'users#manager_panel'
  get 'admin', to: 'users#admin_panel'
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
end
