defmodule BaltimoreAiWeb.SharedView do
  use BaltimoreAiWeb, :view

  alias BaltimoreAiWeb.ListingController
  alias BaltimoreAiWeb.PageController

  import Phoenix.Controller, only: [controller_module: 1, action_name: 1]

  def get_flash_messages(%Plug.Conn{} = conn) do
    conn
    |> Phoenix.Controller.get_flash()
    |> Map.values()
  end

  def show_new_listing_button(conn) do
    current_controller = controller_module(conn)
    current_action = action_name(conn)

    case {current_controller, current_action} do
      {ListingController, :index} -> true
      {ListingController, :index_filtered} -> true
      {ListingController, :search} -> true
      {PageController, :about} -> true
      _ -> false
    end
  end

  def get_telegram_channel(), do: Telegram.get_channel()
end
