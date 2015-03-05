NotifstaWebapp::Application.routes.draw do
  root "pages#home"
  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"
  
  scope 'api' do
    scope 'v1' do
      scope 'auth' do
        get 'login' => 'api_authentication#login'
        get 'logout' => 'api_authentication#logout'
        get 'get_authentication_token' => 'api_authentication#get_authentication_token'
      end
    end
  end
  
  devise_for :users

  namespace :admin do
    root "base#index"
    resources :users
    
  end

end
