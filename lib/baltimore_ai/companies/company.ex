defmodule BaltimoreAi.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset


  schema "companies" do
    field :description, :string
    field :name, :string
    field :slug, :string

    has_many(:listings, BaltimoreAi.Jobs.Listing)

    timestamps()
  end

  @required_attrs [:name]
  @optional_attrs [:description, :slug]
  @attributes @required_attrs ++ @optional_attrs

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, @attributes)
    |> validate_required(@required_attrs)
  end
end
