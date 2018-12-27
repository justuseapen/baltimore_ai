defmodule BaltimoreAi.Repo do
  use Ecto.Repo,
    otp_app: :baltimore_ai,
    adapter: Ecto.Adapters.Postgres
end
