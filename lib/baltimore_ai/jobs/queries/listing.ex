defmodule BaltimoreAi.Jobs.Queries.Listing do
  @moduledoc """
  Module to build queries related to the Listing schema
  """

  import Ecto.Query, warn: false

  def by_id(query, id) do
    from o in query, where: o.id == ^id
  end

  def by_slug(query, slug) do
    from o in query, where: o.slug == ^slug
  end

  def by_job_type(query, nil), do: query

  def by_job_type(query, type) do
    from o in query, where: o.job_type == ^type
  end

  def by_job_place(query, nil), do: query

  def by_job_place(query, place) do
    from o in query, where: o.job_place == ^place
  end

  def by_text(query, nil), do: query

  def by_text(query, text) do
    text
    |> String.split(" ")
    |> Enum.map(&"%#{&1}%")
    |> Enum.reduce(query, fn keyword, q ->
      from o in q,
        where:
          ilike(o.title, ^keyword) or
          ilike(o.description, ^keyword) or
          ilike(o.location, ^keyword) or
          ilike(o.external_url, ^keyword) or
          ilike(o.job_type, ^keyword) or
          ilike(o.job_place, ^keyword)
    end)
  end

  def published(query) do
    from(o in query,
      where: not is_nil(o.published_at) and o.published_at <= ^NaiveDateTime.utc_now(),
      preload: [:company]
    )
  end

  def unpublished(query) do
    from o in query, where: is_nil(o.published_at)
  end

  def order_published(query) do
    from o in query, order_by: [desc: o.published_at]
  end

  def order_inserted(query) do
    from o in query, order_by: [desc: o.inserted_at]
  end
end
