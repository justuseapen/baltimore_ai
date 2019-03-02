defmodule BaltimoreAiWeb.Router do
  use BaltimoreAiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug BaltimoreAi.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug BaltimoreAi.Auth.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", BaltimoreAiWeb do
    pipe_through [:browser, :auth]

    get "/", ListingController, :index
    get "/signup", RegistrationController, :new
    post "/signup", RegistrationController, :create
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    get "/page/:page", ListingController, :index, as: :offer_page
    get "/listings/place/:filter", ListingController, :index_filtered
    get "/listings/type/:filter", ListingController, :index_filtered
    post "/listings/preview", ListingController, :preview
    put "/listings/preview", ListingController, :preview
    get "/search", ListingController, :search

    get "/about", PageController, :about
  end

  scope "/auth", BaltimoreAiWeb do
    pipe_through [:browser, :auth]

    get "/signout", AuthController, :delete
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  scope "/", BaltimoreAiWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    resources "/listings", ListingController, only: [:new, :create, :edit, :update, :delete]
    get "/listings/:slug_or_id", ListingController, :show
    delete "/logout", SessionController, :delete
    resources "/users", UserController
    resources "/companies", CompanyController
  end

end
