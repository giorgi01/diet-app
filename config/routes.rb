Rails.application.routes.draw do
  resources :meals
  root to: 'pages#home'
  devise_for :users
  resources :users, only: [:show, :edit, :update]

  get 'limit/:id', to: 'users#limit_edit', as: 'edit_limit'
  post 'limit/:id', to: 'users#limit_update'
  get 'history', to: 'meals#meals_history', as: 'meals_history'

  get 'filter', to: 'meals#filter_new', as: 'filter'
  post 'filter', to: 'meals#filter', as: 'filter_show'

  get 'manager', to: 'users#manager_panel'
  get 'admin', to: 'users#admin_panel'
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

  post 'users/:id/toggle_manager', to: 'users#toggle_manager', as: 'toggle_manager'

  get 'admin/new_user', to: 'users#admin_new_user'
  post 'admin/new_user', to: 'users#admin_add_user'
end
