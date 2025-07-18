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
  get "export_orders", to: "dashboard#export", as: :export_orders
end



  # === STORE & NESTED RESOURCES ===
  resources :stores do
    resources :products
    resources :orders, only: [:index, :show]
    resources :store_users, only: [:index, :new, :create]
    resources :payment_methods
  end

  resources :orders, only: [:index, :show]

 namespace :customers do
  get 'dashboard', to: 'dashboard#index'
  resource :cart, only: [:show]
  resources :cart_items, only: [:create, :update, :destroy]
  resources :orders, only: [:new, :create, :show, :index]

  resources :stores, only: [] do
    resources :products, only: [:index]

  end
end
namespace :customers do
  resource :profile, only: [:show, :edit, :update]
end

  # config/routes.rb
get '/.well-known/*all', to: proc { [204, {}, ['']] }

end
