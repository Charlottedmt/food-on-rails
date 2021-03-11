Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :meals do
    resources :choices, only: [:new, :create,]
  end
  resources :choices, only: [:update, :edit,]
  resources :restaurants, only: [:show]
  get '/dashboard', to: 'dashboards#dashboard', as: :dashboard
  get '/preferences', to: 'meals#preferences', as: :preferences
  get '/tagged', to: "meals#tagged", as: :tagged



#  get "external" => "http:/www.google.com"
end
