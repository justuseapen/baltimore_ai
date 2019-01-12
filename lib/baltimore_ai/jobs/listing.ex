defmodule BaltimoreAi.Jobs.Listing do
  use Ecto.Schema
  import Ecto.Changeset


  schema "listings" do
    field :description, :string
    field :external_url, :string
    field :poster_id, :integer
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(listing, attrs) do
    listing
    |> cast(attrs, [:title, :description, :poster_id, :external_url])
    |> validate_required([:title, :description, :poster_id, :external_url])
  end
end
