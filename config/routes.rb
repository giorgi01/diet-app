Rails.application.routes.draw do
  resources :meals
  root to: 'pages#home'
  devise_for :users
  get 'limit', to: 'users#limit_edit', as: 'edit_limit'
  post 'limit', to: 'users#limit_update'
end
