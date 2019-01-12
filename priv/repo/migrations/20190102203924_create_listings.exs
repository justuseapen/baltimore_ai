defmodule BaltimoreAi.Repo.Migrations.CreateListings do
  use Ecto.Migration

  def change do
    create table(:listings) do
      add :title, :string
      add :description, :text
      add :poster_id, :integer
      add :external_url, :string

      timestamps()
    end

  end
end
