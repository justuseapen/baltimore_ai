defmodule BaltimoreAi.Auth do

  import Comeonin.Bcrypt, only: [checkpw: 2]

  alias BaltimoreAi.Accounts.User
  alias BaltimoreAi.Repo

  def signup(attrs \\ %{}) do
    %User{}
    |> User.changeset_registration(attrs)
    |> Repo.insert()
  end

  def validate_credentials(email, password) do
    user =
      email
      |> String.downcase()
      |> get_by_email()

    case user do
      nil -> {:error, :unauthorized}
      _ -> app_access(user, password)
    end
  end

  defp app_access(user, password) do
    case check_password(user, password) do
      true -> {:ok, user}
      _ -> {:error, :unauthorized}
    end
  end

  defp get_by_email(email), do: Repo.get_by(User, email: email)

  defp check_password(user, password) do
    case user do
      nil -> false
      _ -> validate_password(password, user.hashed_password)
    end
  end

  defp validate_password(password, hash), do: checkpw(password, hash)
end
