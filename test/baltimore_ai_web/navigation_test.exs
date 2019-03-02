defmodule BaltimoreAiWeb.NavigationTest do
  use BaltimoreAiWeb.ConnCase

  ## Code removed for readability

  test "shows a sign out link when signed in", %{conn: conn} do
    user = user_fixture()

    conn = conn
           |> assign(:user, user)
           |> get("/")

    assert html_response(conn, 200) =~ "Sign out"
  end
end
