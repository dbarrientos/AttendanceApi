Rails.application.routes.draw do
  
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :attendances  
  end
  
  post 'auth/login', to: 'authentication#authenticate'
  resources :users, only: [:update, :destroy] 
  post 'signup', to: 'users#create'
end