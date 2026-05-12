Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # Public directory
  resources :companies, only: [ :index, :show, :edit, :update ], param: :slug
  resources :categories, only: [ :index, :show ], param: :slug
  resources :resources, only: [ :index, :show ], param: :slug
  resources :guides, only: [ :index, :show ], param: :slug

  # Sessions (magic link auth)
  get    "sign-in",         to: "sessions#new",     as: :sign_in_request
  post   "sign-in",         to: "sessions#create",  as: :send_magic_link
  get    "sign-in/verify",  to: "sessions#verify",  as: :sign_in
  delete "sign-out",        to: "sessions#destroy", as: :sign_out

  # Claim flow
  scope "/claim/:slug", controller: "profile_claims" do
    get  "/",         action: :start,    as: :claim
    post "verify",    action: :send_code
    get  "code",      action: :code_form
    post "code",      action: :confirm_code
    get  "wizard/:step", action: :show_step,   as: :claim_wizard_step
    patch "wizard/:step", action: :update_step
  end

  # Admin
  namespace :admin do
    root to: "dashboard#index"
    resources :profile_claims, only: [ :index, :show ] do
      member do
        post :approve
        post :reject
      end
    end
  end

  # Foundational static pages
  get "about",                to: "static#about"
  get "editorial-standards",  to: "static#editorial_standards", as: :editorial_standards
  get "how-it-works",         to: "static#how_it_works",        as: :how_it_works
  get "contact",              to: "static#contact",             as: :contact
  post "contact",             to: "contact_messages#create",    as: :contact_messages
  get "privacy",              to: "static#privacy"
  get "terms",                to: "static#terms"

  # Robots
  get "robots", to: "static#robots", defaults: { format: "txt" }

  root "home#index"
end
