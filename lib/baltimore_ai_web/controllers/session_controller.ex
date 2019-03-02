defmodule BaltimoreAiWeb.SessionController do
  use BaltimoreAiWeb, :controller

  alias BaltimoreAi.Accounts
  alias BaltimoreAi.Auth
  alias BaltimoreAi.Accounts.User
  alias BaltimoreAi.Auth.Guardian

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset, action: Routes.session_path(conn, :create))
  end

  def create(conn, %{"user" => user_params}) do
    case Auth.validate_credentials(
           user_params["email"],
           user_params["password"]
         ) do
      {:ok, user} ->

        conn
        |> Guardian.Plug.sign_in(user)
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Hi, #{user.first_name}!")
        |> redirect(to: Routes.listing_path(conn, :index))

      {:error, message} ->
        changeset = Accounts.change_user(%User{})

        conn
        |> put_flash(:error, message)
        |> render(
          "new.html",
          changeset: changeset,
          action: Routes.session_path(conn, :create)
        )
    end
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out()
    |> configure_session(drop: true)
    |> put_flash(:info, "You have been logged out!")
    |> redirect(to: Routes.listing_path(conn, :index))
  end
end
