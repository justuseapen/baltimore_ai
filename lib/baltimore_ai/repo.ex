defmodule BaltimoreAi.Repo do
  use Ecto.Repo,
    otp_app: :baltimore_ai,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: Application.get_env(:baltimore_ai, :items_per_page)
end
