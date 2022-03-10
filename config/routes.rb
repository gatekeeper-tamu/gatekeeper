Rails.application.routes.draw do
  	resources :groups
  	resources :subscriptions
  	resources :reminders
		resources :statistics

	devise_for :users, controllers: {
		omniauth_callbacks: "users/omniauth_callbacks",
		:registrations => "users/registrations"
	}

	get 'users/:username' => 'users#show', :as => :user_root
	get 'groups/' => 'groups#index', :as => :group_root
	get 'subscriptions/' => 'subscriptions#index', :as => :subscription_root
	get 'search/'=> 'search#index', :as => :search_root
	get 'home/index'
	root 'home#index'
	resources :reminder, path: '/reminders'
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
