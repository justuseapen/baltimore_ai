Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :companies, only: [ :index, :show ], param: :slug
  resources :categories, only: [ :index, :show ], param: :slug
  resources :resources, only: [ :index, :show ], param: :slug

  get "robots", to: "static#robots", defaults: { format: "txt" }

  root "home#index"
end
