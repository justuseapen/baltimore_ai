defmodule Auth.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Auth.Accounts.User

  schema "users" do
    field :hashed_password, :string
    field :permissions, :map
    field :username, :string

    # Add a virtual attribute to hold plain text passwords.
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user

    # Cast and require a password for each user
    |> cast(attrs, [:username, :password, :permissions])
    |> validate_required([:username, :password, :permissions])
    |> unique_constraint(:username)

    # Hash passwords before saving them to the database.
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
