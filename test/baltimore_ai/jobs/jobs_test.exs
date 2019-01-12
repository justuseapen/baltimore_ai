defmodule BaltimoreAi.JobsTest do
  use BaltimoreAi.DataCase

  alias BaltimoreAi.Jobs

  describe "listings" do
    alias BaltimoreAi.Jobs.Listing

    @valid_attrs %{description: "some description", external_url: "some external_url", poster_id: 42, title: "some title"}
    @update_attrs %{description: "some updated description", external_url: "some updated external_url", poster_id: 43, title: "some updated title"}
    @invalid_attrs %{description: nil, external_url: nil, poster_id: nil, title: nil}

    def listing_fixture(attrs \\ %{}) do
      {:ok, listing} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Jobs.create_listing()

      listing
    end

    test "list_listings/0 returns all listings" do
      listing = listing_fixture()
      assert Jobs.list_listings() == [listing]
    end

    test "get_listing!/1 returns the listing with given id" do
      listing = listing_fixture()
      assert Jobs.get_listing!(listing.id) == listing
    end

    test "create_listing/1 with valid data creates a listing" do
      assert {:ok, %Listing{} = listing} = Jobs.create_listing(@valid_attrs)
      assert listing.description == "some description"
      assert listing.external_url == "some external_url"
      assert listing.poster_id == 42
      assert listing.title == "some title"
    end

    test "create_listing/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_listing(@invalid_attrs)
    end

    test "update_listing/2 with valid data updates the listing" do
      listing = listing_fixture()
      assert {:ok, %Listing{} = listing} = Jobs.update_listing(listing, @update_attrs)
      assert listing.description == "some updated description"
      assert listing.external_url == "some updated external_url"
      assert listing.poster_id == 43
      assert listing.title == "some updated title"
    end

    test "update_listing/2 with invalid data returns error changeset" do
      listing = listing_fixture()
      assert {:error, %Ecto.Changeset{}} = Jobs.update_listing(listing, @invalid_attrs)
      assert listing == Jobs.get_listing!(listing.id)
    end

    test "delete_listing/1 deletes the listing" do
      listing = listing_fixture()
      assert {:ok, %Listing{}} = Jobs.delete_listing(listing)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_listing!(listing.id) end
    end

    test "change_listing/1 returns a listing changeset" do
      listing = listing_fixture()
      assert %Ecto.Changeset{} = Jobs.change_listing(listing)
    end
  end
end
