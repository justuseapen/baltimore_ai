defmodule BaltimoreAi.Repo.Migrations.CreateListings do
  use Ecto.Migration

  def change do
    create table(:listings) do
      add :description, :text
      add :external_url, :string
      add :poster_id, :integer
      add :company_id, :integer
      add :published_at, :naive_datetime, default: nil
      add :slug, :string
      add :title, :string

      timestamps()
    end

  end
end
