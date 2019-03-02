defmodule BaltimoreAi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias BaltimoreAi.Accounts.User

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :provider, :string
    field :token, :string
    field :hashed_password, :string
    field :permissions, :map
    field :password, :string, virtual: true

    has_many(:listings, BaltimoreAi.Jobs.Listing)

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
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

  def changeset_registration(%User{} = user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password])
    |> validate_required([:first_name, :email, :password])
    |> unique_constraint(:email)
    |> put_hashed_password()
  end

  defp put_hashed_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :hashed_password, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end

end
