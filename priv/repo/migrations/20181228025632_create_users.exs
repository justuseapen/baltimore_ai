defmodule BaltimoreAi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :provider, :string
      add :token, :string
      add :hashed_password, :string
      add :permissions, :map

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
