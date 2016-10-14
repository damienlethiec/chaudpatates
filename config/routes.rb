Rails.application.routes.draw do
  ActiveAdmin.routes(self)
	mount Attachinary::Engine => "/attachinary"
  devise_for :users,
  	controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  root to: 'pages#home'

  resources :cities, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
