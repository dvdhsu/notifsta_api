NotifstaWebapp::Application.routes.draw do
  root to: 'pages#home'
  get "home", to: "pages#home", as: "home"
  get "event_admin", to: "pages#event_admin", as: "event_admin"

  scope 'api' do
    scope 'v1' do
      scope 'auth' do
        get 'login' => 'api_authentication#login'
        get 'logout' => 'api_authentication#logout'
        get 'get_authentication_token' => 'api_authentication#get_authentication_token'
      end
      resources :users, only: [:index, :show], controller: :api_users
      resources :events, only: [:index, :show], controller: :api_events do
        resources :channels, only: [:index], controller: :api_channels do
          resources :messages, only: [:index, :create], controller: :api_messages
        end
      end
      resources :channels, only: [:show], controller: :api_channels do
        resources :messages, only: [:index, :create], controller: :api_messages
      end
      resources :messages, only: [:show], controller: :api_messages
    end
  end
  
  devise_for :users

  namespace :admin do
    root "base#index"
    resources :users
    
  end

end
