defmodule BaltimoreAiWeb.ListingController do
  use BaltimoreAiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
