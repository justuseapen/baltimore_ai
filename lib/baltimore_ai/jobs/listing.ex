defmodule BaltimoreAi.Jobs.Listing do
  use Ecto.Schema
  import Ecto.Changeset

  schema "listings" do
    field :description, :string
    field :location, :string
    field :job_place, :string
    field :job_type, :string
    field :external_url, :string
    field :title, :string
    field :published_at, :naive_datetime
    field :slug, :string

    belongs_to(:company, BaltimoreAi.Companies.Company)
    belongs_to(:poster, BaltimoreAi.Accounts.User)

    timestamps()
  end

  @required_attrs [:title, :external_url, :description, :poster_id]
  @optional_attrs [:published_at, :slug, :job_place, :job_type, :location]
  @attributes @required_attrs ++ @optional_attrs
  @url_regexp ~r/^\b((https?:\/\/?)[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/)))$/

  @doc false
  def changeset(listing, attrs) do
    listing
    |> cast(attrs, @attributes)
    |> cast_assoc(:company)
    |> validate_required(@required_attrs)
    |> validate_length(:title, min: 5, max: 50)
    |> unique_constraint(:slug)
    |> generate_slug()
  end

  def changeset_update(listing, attrs) do
    listing
    |> cast(attrs, [:title, :external_url, :description, :job_place, :job_type, :location])
    |> cast_assoc(:company)
    |> validate_required(:title)
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
