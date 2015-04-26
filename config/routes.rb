NotifstaWebapp::Application.routes.draw do
  root to: 'pages#home'

  scope 'v1' do
    scope 'auth' do
      get 'login' => 'api_authentication#login'
      get 'logout' => 'api_authentication#logout'
      get 'facebook' => 'api_authentication#facebook_register_or_login'
      get 'login_with_token' => 'api_authentication#login_with_token'
      get 'register' => 'api_authentication#register'
      get 'get_authentication_token' => 'api_authentication#get_authentication_token'
    end
    resources :users, only: [:show], controller: :api_users
    resources :subscriptions, only: [:show, :create, :destroy], controller: :api_subscriptions
    resources :events, only: [:index, :show], controller: :api_events do
      resources :channels, only: [:index], controller: :api_channels
      resources :subscriptions, only: :index, controller: :api_subscriptions
    end
    resources :channels, only: [:show], controller: :api_channels do
      resources :notifications, only: [:index, :create], controller: :api_notifications
    end
    resources :notifications, only: [:show], controller: :api_notifications do
      resources :responses, only: [:index, :show, :create], controller: :api_responses
    end
    resources :responses, only: [:show], controller: :api_responses
  end

  devise_for :users

  namespace :admin do
    root "base#index"
    resources :users
  end

end
