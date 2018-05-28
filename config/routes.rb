Rails.application.routes.draw do
  # devise_for :users
  namespace :v1, default: { format: :json } do
    resources :users, only: :create
    resources :sessions, only: [:create, :destroy]
    get '/resources' => 'resources#index'
  end
end
