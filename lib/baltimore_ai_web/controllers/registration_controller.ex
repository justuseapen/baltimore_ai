defmodule BaltimoreAiWeb.RegistrationController do
  use BaltimoreAiWeb, :controller

  alias BaltimoreAi.Auth
  alias BaltimoreAi.Accounts
  alias BaltimoreAi.Accounts.User

  def new(conn, params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Auth.signup(user_params) do
      {:ok, %User{} = user} ->
        conn
        |> put_flash(:info, "#{user.email} signed up successfully.")
        |> redirect(to: Routes.listing_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)

    end
  end

end
