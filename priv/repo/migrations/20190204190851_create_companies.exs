defmodule BaltimoreAi.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :description, :text
      add :external_url, :string
      add :name, :string
      add :slug, :string

      timestamps()
    end

  end
end
