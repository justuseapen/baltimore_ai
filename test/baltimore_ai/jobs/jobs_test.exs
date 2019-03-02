defmodule BaltimoreAi.JobsTest do
  use BaltimoreAi.DataCase

  alias BaltimoreAi.Jobs

  describe "listings" do
    alias BaltimoreAi.Jobs.Listing

    @valid_attrs %{
      description: Faker.Lorem.sentence(),
      location: Faker.Address.city(),
      job_place: Enum.random(["remote", "onsite"]),
      job_type: Enum.random(["full-time", "part-time", "contract"]),
      external_url: Faker.Internet.url(:safe),
      title: Faker.Name.title(),
      published_at: Faker.Date.forward(1..5),
      slug: Faker.Internet.user_name(),
      poster_id: 1
    }
    @update_attrs %{
      description: Faker.Lorem.sentence(),
      location: Faker.Address.city(),
      job_place: Enum.random(["remote", "onsite"]),
      job_type: Enum.random(["full-time", "part-time", "contract"]),
      external_url: Faker.Internet.url(:safe),
      title: Faker.Name.title(),
      published_at: Faker.Date.forward(1..5),
      slug: Faker.Internet.user_name(),
      poster_id: 1
    }
    @invalid_attrs %{
      description: nil,
      location: nil,
      job_place: nil,
      job_type: nil,
      external_url: nil,
      title: nil,
      published_at: nil,
      slug: nil,
      poster_id: nil
    }

    setup do
      user = insert(:user, id: 1)
      listing = insert(:listing)
      {:ok, %{listing: listing, user: user}}
    end

    test "list_listings/0 returns all listings", %{listing: listing} do
      assert Jobs.list_listings() |> Repo.preload(:poster) == [listing]
    end

    test "get_listing!/1 returns the listing with given id", %{listing: listing} do
      assert Jobs.get_listing!(listing.id) |> Repo.preload(:poster) == listing
    end

    test "create_listing/1 with valid data creates a listing" do
      assert {:ok, %Listing{} = listing} = Jobs.create_listing(@valid_attrs)
      assert listing.description == @valid_attrs.description
      assert listing.external_url == @valid_attrs.external_url
      assert listing.title == @valid_attrs.title
    end

    test "create_listing/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_listing(@invalid_attrs)
    end

    test "update_listing/2 with valid data updates the listing", %{listing: listing} do
      assert {:ok, %Listing{} = listing} = Jobs.update_listing(listing, @update_attrs)
      assert listing.description == @update_attrs.description
      assert listing.external_url == @update_attrs.external_url
      assert listing.title == @update_attrs.title
    end

    test "update_listing/2 with invalid data returns error changeset", %{listing: listing} do
      assert {:error, %Ecto.Changeset{}} = Jobs.update_listing(listing, @invalid_attrs)
      assert listing == Jobs.get_listing!(listing.id) |> Repo.preload(:poster)
    end

    test "delete_listing/1 deletes the listing" do
      listing = insert(:listing)
      assert {:ok, %Listing{}} = Jobs.delete_listing(listing)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_listing!(listing.id) end
    end

    test "change_listing/1 returns a listing changeset" do
      listing = insert(:listing)
      assert %Ecto.Changeset{} = Jobs.change_listing(listing)
    end
  end
end
