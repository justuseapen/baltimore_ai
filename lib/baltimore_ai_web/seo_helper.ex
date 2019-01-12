defmodule BaltimoreAiWeb.SeoHelper do
  @moduledoc """
  Module with SEO-related functions like the ones to generate descriptions,
  titles, etc.
  """

  use BaltimoreAiWeb, :view

  import Phoenix.Controller, only: [controller_module: 1, action_name: 1]

  @default_page_title "Find AI jobs in Baltimore!"
  @default_page_description "Baltimore is a top city for AI talent. Find AI jobs and talent here. Data science, modelling, neural networks, reinforcement learning, roles and jobs for all kinds of companies. AI jobs in cyber security, consulting, freelancing, government, non profits, remote jobs and more."

  alias BaltimoreAi.Jobs.Listing
  alias BaltimoreAiWeb.ListingController
  alias BaltimoreAiWeb.PageController

  def page_title(%Plug.Conn{} = conn) do
    get_page_title(controller_module(conn), action_name(conn), conn.assigns, conn.params)
  end
  def page_title(_), do: gettext(@default_page_title)

  def page_description(%Plug.Conn{} = conn) do
    get_page_description(controller_module(conn), action_name(conn), conn.assigns)
  end
  def page_description(_), do: gettext(@default_page_description)

  # PRIVATE METHODS

  defp get_page_title(ListingController, :new, _, _), do: gettext("Publish a job offer")

  defp get_page_title(ListingController, action, _, params)
  when action in [:index_filtered, :search] do
    job_type =
      params
      |> Map.get("filters", %{})
      |> Map.get("job_type", "")

    job_place =
      params
      |> Map.get("filters", %{})
      |> Map.get("job_place", "")

    case {job_type, job_place} do
      {"full_time", ""} -> gettext("Full time Elixir job offers")
      {"part_time", ""} -> gettext("Part time Elixir job offers")
      {"freelance", ""} -> gettext("Freelance Elixir job offers")
      {"", "onsite"} -> gettext("On site Elixir job offers")
      {"", "remote"} -> gettext("Remote Elixir job offers")
      _ -> gettext(@default_page_title)
    end
  end

  defp get_page_title(ListingController, :show, %{:offer => %Listing{} = offer}, _),
    do: "#{offer.title} @ #{offer.company}"

  defp get_page_title(PageController, :about, _, _), do: gettext("About")

  defp get_page_title(AuthController, action, _, _) when action in [:new, :create],
    do: gettext("Log in")

  defp get_page_title(_, _, _, _), do: gettext(@default_page_title)

  defp get_page_description(ListingController, :new, _),
    do:
  gettext(
    "Post your job offer to reach more Elixir developers and find the right hire for your company!"
  )

  defp get_page_description(ListingController, :show, %{:offer => %Listing{} = offer}) do
    offer.summary
    |> HtmlSanitizeEx.strip_tags()
    |> String.slice(0, 100)
  end

  defp get_page_description(PageController, :about, _),
    do:
  gettext(
    "Built on Elixir + Phoenix, Elixir Jobs is a open source project that aims to help Elixir developers to find their next dream job."
  )

  defp get_page_description(_, _, _), do: gettext(@default_page_description)
end
