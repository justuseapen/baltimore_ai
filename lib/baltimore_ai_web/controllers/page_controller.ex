defmodule BaltimoreAiWeb.PageController do
  use BaltimoreAiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def about(conn, _params) do
    render(conn, "about.html")
  end
end
