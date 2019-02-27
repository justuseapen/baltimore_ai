use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :baltimore_ai, BaltimoreAiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Ueberauth Config for oauth
config :ueberauth, Ueberauth,
  providers: [ google: { Ueberauth.Strategy.Google, [default_scope: "emails profile plus.me"] } ]

# Configure your database
config :baltimore_ai, BaltimoreAi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("DATA_DB_USER"),
  password: System.get_env("DATA_DB_PASS"),
  hostname: System.get_env("DATA_DB_HOST"),
  database: "baltimore_ai_test",
  pool: Ecto.Adapters.SQL.Sandbox
