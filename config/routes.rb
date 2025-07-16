Rails.application.routes.draw do

devise_for :users, controllers: {
  registrations: 'users/registrations',
  invitations: 'users/invitations',
  sessions: 'users/sessions'
}
devise_for :customers, controllers: {
  registrations: "customers/registrations",
  sessions: "customers/sessions" 
}

  root to: "owner/dashboard#index"

  # === DASHBOARDS ===
  namespace :owner do
    get "dashboard", to: "dashboard#index"
  end

  namespace :stock_manager do
    get "dashboard", to: "dashboard#index"
  end

  namespace :dispatcher do
    get "dashboard", to: "dashboard#index"
  end



  # === STORE & NESTED RESOURCES ===
  resources :stores do
    resources :products, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :orders, only: [:index, :show]
    resources :store_users, only: [:index, :new, :create]
  end

  resources :orders, only: [:index, :show]

 namespace :customers do
  get 'dashboard', to: 'dashboard#index'
  resource :cart, only: [:show]
  resources :cart_items, only: [:create, :destroy]
  resources :products, only: [:index, :show]
end

  # config/routes.rb
get '/.well-known/*all', to: proc { [204, {}, ['']] }

end
