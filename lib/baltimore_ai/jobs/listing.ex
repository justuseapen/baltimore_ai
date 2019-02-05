defmodule BaltimoreAi.Jobs.Listing do
  use Ecto.Schema
  import Ecto.Changeset

  schema "listings" do
    field :company_id, :integer
    field :description, :string
    field :external_url, :string
    field :poster_id, :integer
    field :title, :string
    field :published_at, :naive_datetime
    field :slug, :string

    timestamps()
  end

  @required_attrs [:title, :external_url, :description]
  @optional_attrs [:published_at, :slug, :poster_id, :company_id]
  @attributes @required_attrs ++ @optional_attrs
  @url_regexp ~r/^\b((https?:\/\/?)[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/)))$/

  @doc false
  def changeset(listing, attrs) do
    listing
    |> cast(attrs, @attributes)
    |> validate_required(@required_attrs)
    |> validate_length(:title, min: 5, max: 50)
    |> unique_constraint(:slug)
    |> generate_slug()
  end

  defp generate_slug(%Ecto.Changeset{valid?: false} = changeset) do
    changeset
  end
  defp generate_slug(changeset) do
    case get_field(changeset, :slug) do
      nil -> put_change(changeset, :slug, do_generate_slug(changeset))
      _ -> changeset
    end
  end

  defp do_generate_slug(changeset) do
    uid =
      Ecto.UUID.generate()
      |> to_string()
      |> String.split("-")
      |> List.first()

    title =
      changeset
      |> get_field(:title)
      |> Slugger.slugify_downcase()

    company = "Company Name"

    "#{company}-#{title}-#{uid}"
  end
end
