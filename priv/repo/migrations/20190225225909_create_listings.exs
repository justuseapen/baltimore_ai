defmodule BaltimoreAi.Repo.Migrations.CreateListings do
  use Ecto.Migration

  def change do
    create table(:listings) do
      add :title, :string
      add :description, :text
      add :company_id, references(:companies, on_delete: :delete_all, type: :integer)
      add :location, :string
      add :external_url, :string
      add :poster_id, references(:users, on_delete: :delete_all, type: :integer)
      add :published_at, :naive_datetime, default: nil
      add :slug, :string
      add :job_place, :string
      add :job_type, :string

      timestamps()
    end

    create index(:listings, [:company_id])
    create index(:listings, [:poster_id])
  end
end
