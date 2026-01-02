Rails.application.routes.draw do
  get "dashboard/index"
  get "home/index"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root "home#index"
  get "dashboard", to: "dashboard#index"
  resources :organizations, only: %i[index new create]
  resource :organization_switch, only: :update
  resources :organization_members, only: %i[index create]
  get "google/oauth/connect", to: "google/oauth#connect", as: :connect_google
  get "google/oauth/callback", to: "google/oauth#callback"
  post "organizations/switch", to: "organizations#switch", as: :switch_organization
  namespace :admin do
    resources :google_users, only: :index
  end

  resources :organizations do
    get :settings, on: :member
  end
end
