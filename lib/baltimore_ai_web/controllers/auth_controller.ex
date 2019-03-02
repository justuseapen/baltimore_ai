defmodule BaltimoreAiWeb.AuthController do
  use BaltimoreAiWeb, :controller
  plug Ueberauth

  alias BaltimoreAi.Auth.Guardian
  alias BaltimoreAi.Accounts.User
  alias BaltimoreAi.Repo

  def request(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = user_params(auth)
    changeset = User.changeset(%User{}, user_params)

    callback(conn, changeset)
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = user_params(auth)

    changeset = User.changeset(%User{}, user_params)
    case insert_or_update_user(changeset) do
      {:ok, user} ->

        conn
        |> Guardian.Plug.sign_in(user)
        |> put_flash(:info, "Thank you for signing in!")
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.listing_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: Routes.listing_path(conn, :index))
    end
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: Routes.listing_path(conn, :index))
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: Routes.listing_path(conn, :index))
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok, user}
    end
  end

  defp user_params(auth, provider \\ "google") do
    %{
      token: auth.credentials.token,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      email: auth.info.email,
      provider: provider
    }
  end
end
