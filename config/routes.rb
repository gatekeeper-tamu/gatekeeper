Rails.application.routes.draw do
	resources :groups
	resources :subscriptions do
    member do
      get :share
    end
  end
	resources :reminders
  resources :statistics
  resources :temp_shared_subscriptions, :path => '/shares', only: [:index, :edit, :show, :update, :destroy ] do
    get "share", on: :member
    patch "send_temp_access_email", on: :member
  end

  devise_for :users, controllers: {
	  omniauth_callbacks: "users/omniauth_callbacks",
	  :registrations => "users/registrations"
  }


  get 'users/:username' => 'users#show', :as => :user_root
  get 'groups/' => 'groups#index', :as => :group_root
  get 'subscriptions/' => 'subscriptions#index', :as => :subscription_root
  get 'reminders/' => 'reminders#index', :as => :reminder_root
  get '/search', to: 'search#index'
	post 'search/show'
  
  get 'home/index'
  root 'home#index'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
