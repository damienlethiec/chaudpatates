Rails.application.routes.draw do
	require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
  ActiveAdmin.routes(self)
	mount Attachinary::Engine => "/attachinary"
  devise_for :users,
  	controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  root to: 'pages#home'

  resources :cities, only: [:show]
  resources :trainings, only: [:index, :destroy]
  resources :bookings, only: [:index, :create, :destroy]
  resources :orders, only: [:create] do
    resources :payments, only: [:create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
