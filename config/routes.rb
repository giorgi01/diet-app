Rails.application.routes.draw do
  resources :meals
  root to: 'pages#home'
  devise_for :users
end
