defmodule BaltimoreAiWeb.PageControllerTest do
  use BaltimoreAiWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Baltimore Ai"
  end
end
