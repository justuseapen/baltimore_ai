# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :baltimore_ai,
  ecto_repos: [BaltimoreAi.Repo]

# Configures the endpoint
config :baltimore_ai, BaltimoreAiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: BaltimoreAiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BaltimoreAi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Ueberauth Config for oauth
config :ueberauth, Ueberauth,
  providers: [
    google: {
      Ueberauth.Strategy.Google,
      [
        default_scope: "emails profile plus.me"
      ]
    }
  ]

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

config :canary,
  repo: BaltimoreAi.Repo,
  unauthorized_handler: {BaltimoreAi.Auth.ErrorHandler, :handle_unauthorized},
  not_found_handler: {BaltimoreAi.Auth.ErrorHandler, :handle_not_found}

# Configures authentication with Guardian
config :baltimore_ai, BaltimoreAi.Auth.Guardian,
  issuer: "BaltimoreAi",
  ttl: {30, :days},
  # optional
  allowed_algos: ["HS256"],
  verify_issuer: true

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
