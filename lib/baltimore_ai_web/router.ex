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

  scope "/", BaltimoreAiWeb do
    pipe_through :browser
    resources "/companies", CompanyController

    resources "/listings", ListingController
    get "/page/:page", ListingController, :index, as: :offer_page
    get "/search", ListingController, :search
    get "/listings/place/:filter", ListingController, :index_filtered
    get "/listings/type/:filter", ListingController, :index_filtered
    post "/listings/preview", ListingController, :preview
    put "/listings/preview", ListingController, :preview
    get "/listings/:slug", ListingController, :show

    resources "/users", UserController

    get "/", ListingController, :index
    get "/about", PageController, :about
  end

  scope "/auth", BaltimoreAiWeb do
    pipe_through :browser

    get "/signout", AuthController, :delete
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :new
  end
end
