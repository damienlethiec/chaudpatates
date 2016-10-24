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
  resources :bookings, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
