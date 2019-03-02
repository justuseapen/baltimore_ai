defmodule BaltimoreAiWeb.SessionHelper do

  use Phoenix.ConnTest

  @endpoint BaltimoreAiWeb.Endpoint

  alias BaltimoreAiWeb.Router.Helpers, as: Routes

  alias FakerElixir, as: Faker

  def authenticated_session() do
    conn = Phoenix.ConnTest.build_conn()

    {:ok, user} =
      BaltimoreAi.Repo.insert(
        %BaltimoreAi.Accounts.User{
          first_name: Faker.Name.first_name(),
          last_name: Faker.Name.last_name(),
          email: Faker.Internet.email(),
          hashed_password: "$2b$12$HaSA5EZeWPmBzynzOU.7cutROZ.5wRqM/zJwu3kWACWUZbZ7JdKwi"
        }
      )

    conn =
      post(
        conn,
        Routes.session_path(conn, :create),
        user: %{
          email: user.email,
          password: "test.112"
        }
      )

    {:ok, conn: conn, user: user}
  end

end
