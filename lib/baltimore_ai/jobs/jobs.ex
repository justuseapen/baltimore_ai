defmodule BaltimoreAi.Jobs do
  @moduledoc """
  The Jobs context.
  """

  import Ecto.Query, warn: false
  alias BaltimoreAi.Repo
  alias BaltimoreAi.Jobs.Queries.Listing, as: ListingQuery

  alias BaltimoreAi.Jobs.Listing

  @doc """
  Returns the list of listings.

  ## Examples

      iex> list_listings()
      [%Listing{}, ...]

      iex> list_offers(page_no)
      [%Listing{}, ...]

  """
  def list_listings(page \\ nil) do
    query = ListingQuery.order_inserted(Listing)

    case page do
      page_no when is_integer(page_no) and page_no > 0 ->
        Repo.paginate(query, page: page)

      _ ->
        Repo.all(query)
    end
  end

  @doc """
  Returns the list of published offers.

  ## Examples

      iex> list_published_listingss()
      [%Listing{}, ...]

      iex> list_published_listings(page_no)
      [%Listing{}, ...]

  """
  def list_published_listings(page \\ nil) do
    query =
      Listing
      |> ListingQuery.published()
      |> ListingQuery.order_published()

    case page do
      page_no when is_integer(page_no) and page_no > 0 ->
        Repo.paginate(query, page: page)

      _ ->
        Repo.all(query)
    end
  end


  @doc """
  Gets a single listing.

  Raises `Ecto.NoResultsError` if the Listing does not exist.

  ## Examples

      iex> get_listing!(123)
      %Listing{}

      iex> get_listing!(456)
      ** (Ecto.NoResultsError)

  """
  # as we expect the url to be ``/listings/:slug`, we should get listing by
  # slug instead id here.
  def get_listing!(slug), do: Repo.get_by!(Listing, slug: slug)

  @doc """
  Creates a listing.

  ## Examples

      iex> create_listing(%{field: value})
      {:ok, %Listing{}}

      iex> create_listing(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_listing(attrs \\ %{}) do
    %Listing{}
    |> Listing.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a listing for a user.

  ## Examples

      iex> create_listing(%{field: value}, user)
      {:ok, %Listing{}}

      iex> create_listing(%{field: bad_value}, user)
      {:error, %Ecto.Changeset{}}

  """
  # If login is mandatory to create a job offer, we can use this function to
  # associate it to the current user
  def create_listing(attrs, user) do
    user
    |> Ecto.build_assoc(:listings)
    |> Listing.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a listing.

  ## Examples

      iex> update_listing(listing, %{field: new_value})
      {:ok, %Listing{}}

      iex> update_listing(listing, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_listing(%Listing{} = listing, attrs) do
    listing
    |> Listing.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Listing.

  ## Examples

      iex> delete_listing(listing)
      {:ok, %Listing{}}

      iex> delete_listing(listing)
      {:error, %Ecto.Changeset{}}

  """
  def delete_listing(%Listing{} = listing) do
    Repo.delete(listing)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking listing changes.

  ## Examples

      iex> change_listing(listing)
      %Ecto.Changeset{source: %Listing{}}

  """
  def change_listing(%Listing{} = listing) do
    Listing.changeset(listing, %{})
  end

  @doc """
  Updates a listing.

  ## Examples

      iex> update_listing(listing, %{field: new_value})
      {:ok, %Listing{}}

      iex> update_listing(listing, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_listing(%Listing{} = listing, attrs) do
    listing
    |> Listing.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Publishes an Listing.
  Optionally you can provide a publication date

  ## Examples

      iex> publish_listing(listing)
      {:ok, %Listing{}}

      iex> publish_listing(listing, ~N[2002-01-13 23:00:07])
      {:ok, %Listing{}}

  """
  def publish_listing(%Listing{} = listing), do: publish_listing(listing, NaiveDateTime.utc_now())

  def publish_listing(%Listing{} = listing, date) do
    update_listing(listing, %{published_at: date})
  end
end
