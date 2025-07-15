Rails.application.routes.draw do
devise_for :users, controllers: {
  registrations: 'users/registrations',
  invitations: 'users/invitations'
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

  # config/routes.rb
get '/.well-known/*all', to: proc { [204, {}, ['']] }

end
