defmodule BaltimoreAiWeb.Router do
  use BaltimoreAiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BaltimoreAiWeb do
    pipe_through :browser

    resources "/listings", ListingController
    resources "/users", UserController

    get "/", ListingController, :index
  end

  scope "/auth", BaltimoreAiWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :new
  end
end
