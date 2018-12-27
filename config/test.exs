use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :baltimore_ai, BaltimoreAiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :baltimore_ai, BaltimoreAi.Repo,
  username: "postgres",
  password: "postgres",
  database: "baltimore_ai_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
