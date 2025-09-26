Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  
  # Health check endpoint
  get '/health', to: 'health#show'
  
  # API routes
  namespace :api do
    namespace :v1 do
      # Authentication routes
      post 'auth/login', to: 'auth#login'
      post 'auth/register', to: 'auth#register'
      post 'auth/refresh', to: 'auth#refresh'
      delete 'auth/logout', to: 'auth#logout'
      
      # Payment routes
      resources :payments, only: [:index, :show, :create]
      resources :wallets, only: [:index, :show, :create]
      resources :transactions, only: [:index, :show]
      
      # Analytics routes
      get 'analytics/dashboard', to: 'analytics#dashboard'
      get 'analytics/transactions', to: 'analytics#transactions'
      get 'analytics/revenue', to: 'analytics#revenue'
    end
  end
  
  # Admin routes
  namespace :admin do
    resources :users
    resources :payments
    resources :transactions
    resources :settings
  end
end