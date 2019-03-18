Rails.application.routes.draw do
  
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :attendances  
  end
  
  post 'auth/admin_login', to: 'authentication#admin_authenticate'
  post 'auth/user_login', to: 'authentication#employee_authenticate'
  resources :users, only: [:update, :destroy, :index, :show] 
  post 'signup', to: 'users#create'
end