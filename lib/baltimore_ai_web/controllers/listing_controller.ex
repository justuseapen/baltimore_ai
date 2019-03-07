defmodule BaltimoreAiWeb.ListingController do
  use BaltimoreAiWeb, :controller

  alias BaltimoreAi.Jobs
  alias BaltimoreAi.Jobs.Listing

  @filters_available ["text", "job_type", "job_place"]

  plug(
    :load_and_authorize_resource,
    model: Listing,
    only: [:edit, :update, :delete],
    non_id_actions: [:unpublished_search, :unpublished_listings]
  )

  def index(conn, params) do
    page_number = get_page_number(params)

    page = Jobs.list_published_listings(page_number)

    conn
    |> assign(:listings, page.entries)
    |> assign(:page_number, page.page_number)
    |> assign(:total_pages, page.total_pages)
    |> render("index.html")
  end

  def unpublished_listings(conn, params) do
    page_number = get_page_number(params)

    page = Jobs.list_unpublished_listings(page_number)

    conn
    |> assign(:listings, page.entries)
    |> assign(:page_number, page.page_number)
    |> assign(:total_pages, page.total_pages)
    |> render("unpublished_listings.html")
  end

  def new(conn, _params) do
    changeset = Jobs.change_listing(%Listing{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"listing" => listing_params}) do
    current_user = Guardian.Plug.current_resource(conn)

    case Jobs.create_listing(listing_params, current_user) do
      {:ok, listing} ->
        conn
        |> put_flash(:info, "Listing created successfully.")
        |> redirect(to: Routes.listing_path(conn, :show, listing))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"slug_or_id" => slug_or_id}) do
    listing = Jobs.get_listing!(slug_or_id)
    render(conn, "show.html", listing: listing)
  end

  def edit(conn, %{"id" => id}) do
    listing = Jobs.get_listing!(id) |> BaltimoreAi.Repo.preload(:company)
    changeset = Jobs.change_listing(listing)
    render(conn, "edit.html", listing: listing, changeset: changeset)
  end

  def update(conn, %{"id" => id, "listing" => listing_params}) do
    listing = Jobs.get_listing!(id) |> BaltimoreAi.Repo.preload(:company)

    case Jobs.update_listing(listing, listing_params) do
      {:ok, listing} ->
        conn
        |> put_flash(:info, "Listing updated successfully.")
        |> redirect(to: Routes.listing_path(conn, :show, listing))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", listing: listing, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    listing = Jobs.get_listing!(id)
    {:ok, _listing} = Jobs.delete_listing(listing)

    conn
    |> put_flash(:info, "Listing deleted successfully.")
    |> redirect(to: Routes.listing_path(conn, :index))
  end

  def search(conn, params) do
    page_number = get_page_number(params)

    filters =
      params
      |> Map.get("filters", %{})
      |> Enum.reduce(%{}, fn {k, v}, acc ->
        case {k, v} do
          {key, _} when key not in @filters_available -> acc
          {_, val} when val in ["", nil] -> acc
          {key, str} when is_binary(str) -> Map.put(acc, key, String.trim(str))
          {key, val} -> Map.put(acc, key, val)
        end
      end)
      |> Enum.reject(fn {_, v} -> is_nil(v) or v == "" end)
      |> Enum.into(%{})

    page = Jobs.filter_published_offers(filters, page_number)

    conn
    |> assign(:offers, page.entries)
    |> assign(:page_number, page.page_number)
    |> assign(:total_pages, page.total_pages)
    |> render("search.html")
  end

  def unpublished_search(conn, params) do
    page_number = get_page_number(params)

    filters =
      params
      |> Map.get("filters", %{})
      |> Enum.reduce(%{}, fn {k, v}, acc ->
        case {k, v} do
          {key, _} when key not in @filters_available -> acc
          {_, val} when val in ["", nil] -> acc
          {key, str} when is_binary(str) -> Map.put(acc, key, String.trim(str))
          {key, val} -> Map.put(acc, key, val)
        end
      end)
      |> Enum.reject(fn {_, v} -> is_nil(v) or v == "" end)
      |> Enum.into(%{})

    page = Jobs.filter_unpublished_offers(filters, page_number)

    conn
    |> assign(:offers, page.entries)
    |> assign(:page_number, page.page_number)
    |> assign(:total_pages, page.total_pages)
    |> render("search.html")
  end

  defp get_page_number(params) do
    with {:ok, page_no} <- Map.fetch(params, "page"),
         true <- is_binary(page_no),
         {value, _} <- Integer.parse(page_no) do
      value
    else
      _ -> 1
    end
  end
end
