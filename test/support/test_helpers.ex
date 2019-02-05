defmodule BaltimoreAi.TestHelpers do
  alias BaltimoreAi.Repo
  alias BaltimoreAi.Accounts.User

  def user_fixture(attrs \\ %{}) do
    params =
      attrs
      |> Enum.into(%{
        first_name: "Tony",
        last_name: "Stark",
        email: "ironman#{System.unique_integer([:positive])}@example.com",
        token: "2u9dfh7979hfd",
        provider: "google"
      })

    {:ok, user} =
      User.changeset(%User{}, params)
      |> Repo.insert()

    user
  end
end
