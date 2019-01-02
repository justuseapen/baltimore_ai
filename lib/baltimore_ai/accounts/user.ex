defmodule BaltimoreAi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :provider, :string
    field :token, :string
    field :hashed_password, :string
    field :permissions, :map

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :email,
      :first_name,
      :last_name,
      :provider,
      :token,
      :hashed_password,
      :permissions
    ])
    |> validate_required([:email])
    |> unique_constraint(:email)
  end
end
