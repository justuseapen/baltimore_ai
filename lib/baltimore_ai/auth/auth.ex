defmodule BaltimoreAi.Auth do

  alias BaltimoreAi.Accounts.User
  alias BaltimoreAi.Repo

  def signup(attrs \\ %{}) do
    %User{}
    |> User.changeset_registration(attrs)
    |> Repo.insert()
  end
end
