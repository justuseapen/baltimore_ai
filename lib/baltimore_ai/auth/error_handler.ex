defmodule BaltimoreAi.Auth.ErrorHandler do

  def auth_error(conn, {type, _reason}, _opts) do
    body = to_string(type)

    conn
    |> Phoenix.Controller.put_flash(:error, body)
    |> Phoenix.Controller.redirect(to: BaltimoreAiWeb.Router.Helpers.listing_path(conn, :index))
    |> Plug.Conn.halt()
  end

  def handle_unauthorized(conn) do
    conn
    |> Phoenix.Controller.put_flash(:error, "Access Denied")
    |> Phoenix.Controller.redirect(to: BaltimoreAiWeb.Router.Helpers.listing_path(conn, :index))
    |> Plug.Conn.halt()
  end

  def handle_not_found(conn) do
    conn
    |> Phoenix.Controller.put_flash(:error, "Not Found")
    |> Phoenix.Controller.redirect(to: BaltimoreAiWeb.Router.Helpers.listing_path(conn, :index))
    |> Plug.Conn.halt()
  end

end
