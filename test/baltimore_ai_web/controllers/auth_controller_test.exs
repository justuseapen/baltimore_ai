defmodule BaltimoreAiWeb.AuthControllerTest do
  use BaltimoreAiWeb.ConnCase

  import Mock

  alias BaltimoreAi.Repo
  alias BaltimoreAi.Accounts.User

  @google_oauth_url "https://accounts.google.com/o/oauth2/v2/auth"
  @query_strings "?client_id=google-client-id&redirect_uri=http%3A%2F%2Fwww.example.com%2Fauth%2Fgoogle%2Fcallback&response_type=code&scope=emails+profile+plus.me"
  @google_oauth_html_response "<html><body>You are being <a href=\"#{@google_oauth_url}?client_id=google-client-id&amp;redirect_uri=http%3A%2F%2Fwww.example.com%2Fauth%2Fgoogle%2Fcallback&amp;response_type=code&amp;scope=emails+profile+plus.me\">redirected</a>.</body></html>"
  @ueberauth_auth %Ueberauth.Auth{
    credentials: %Ueberauth.Auth.Credentials{
      token: "some_token",
    },
    info: %Ueberauth.Auth.Info{
      email: "brucewayne@waynetech.com",
      first_name: "Bruce",
      last_name: "Wayne",
    },
    provider: :google
  }
  @ueberauth_failure %Ueberauth.Failure{
    errors: [
      %Ueberauth.Failure.Error{
        message: "No code received",
        message_key: "missing_code"
      }
    ]
  }

  test "redirects user to Google Authentication", %{conn: conn} do
    with_mock(HTTPotion, [get: fn(_url) -> @google_oauth_html_response end]) do
      conn = get(conn, Routes.auth_path(conn, :request, :google))
      assert @google_oauth_html_response == conn.resp_body
      assert redirected_to(conn, 302) == @google_oauth_url <> @query_strings
    end
  end

  test "creates user from Google response", %{conn: conn} do
    conn =
      conn
      |> assign(:ueberauth_auth, @ueberauth_auth)
      |> get(Routes.auth_path(conn, :callback, :google))

    assert Repo.aggregate(User, :count, :id) == 1
    assert get_flash(conn, :info) == "Thank you for signing in!"
  end

  test "does not create user with invalid response", %{conn: conn} do
    conn =
      conn
      |> assign(:ueberauth_failure, @ueberauth_failure)
      |> get(Routes.auth_path(conn, :callback, :google))

    assert Repo.aggregate(User, :count, :id) == 0
    assert redirected_to(conn, 302) == Routes.listing_path(conn, :index)
    assert assert get_flash(conn, :error) == "Failed to authenticate."
  end

  test "signs out user", %{conn: conn} do
    user = user_fixture()

    conn =
      conn
      |> assign(:user, user)
      |> get("/auth/signout")
    |> get("/")

    assert conn.assigns.user == nil
  end
end
