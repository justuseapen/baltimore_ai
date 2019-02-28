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

config :baltimore_ai, BaltimoreAi.Auth.Guardian,
  secret_key: System.get_env("GUARDIAN_SECRET_KEY")
  
# Configure your database
config :baltimore_ai, BaltimoreAi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("DATA_DB_USER") || "postgres",
  password: System.get_env("DATA_DB_PASS") || "postgres",
  hostname: System.get_env("DATA_DB_HOST") || "localhost",
  database: "baltimore_ai_test",
  pool: Ecto.Adapters.SQL.Sandbox
